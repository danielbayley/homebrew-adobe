require 'nokogiri'

ADOBE_COMMON = '/Library/Application Support/Adobe'.freeze

cask 'media-encoder-cc' do
  version '13.0.0.203,2019'
  sha256 '153cac6cb613f0b9a90d327ec1066dfb6b0a24218644eabb1758608996b7f85b'

  language('cs')    { 'cs_CZ' }
  language('da')    { 'da_DK' }
  language('de')    { 'de_DE' }
  language('en-AE') { 'en_AE' }
  language('en-GB') { 'en_GB' }
  language('en-IL') { 'en_IL' }
  language('es')    { 'es_ES' }
  language('es-MX') { 'es_MX' }
  language('fi')    { 'fi_FI' }
  language('fr-CA') { 'fr_CA' }
  language('fr')    { 'fr_FR' }
  language('fr-MA') { 'fr_MA' }
  language('hu')    { 'hu_HU' }
  language('it')    { 'it_IT' }
  language('ja')    { 'ja_JP' }
  language('ko')    { 'ko_KR' }
  language('nb')    { 'nb_NO' }
  language('nl')    { 'nl_NL' }
  language('pl')    { 'pl_PL' }
  language('pt')    { 'pt_BR' }
  language('ro')    { 'ro_RO' }
  language('ru')    { 'ru_RU' }
  language('sv')    { 'sv_SE' }
  language('tr')    { 'tr_TR' }
  language('uk')    { 'uk_UA' }
  language('zh')    { 'zh_CN' }
  language('zh-TW') { 'zh_TW' }
  language 'en', default: true do
    prefs, * = Dir["#{ADOBE_COMMON}/OOBE/com.adobe.accc.apps.*.prefs"]
    if ARGV.grep(%r{--language}).empty? && prefs
      xml = Nokogiri::XML File.read prefs
      property = Nokogiri::XML CGI.unescapeHTML xml.at '//property/text()'
      property.at '//installLanguage/text()'
    else 'en_US'
    end
  end

  url "http://prdl-download.adobe.com/Adobe%20Media%20Encoder/8C05BEDA6290488E8C66EA85A85A5C49/1544088605036/AdobeMediaEncoder#{version.major}AllTrial.dmg"
  name "Adobe Media Encoder CC #{version.after_comma}"
  *, sap_code = name 'AME'
  homepage 'https://www.adobe.com/products/media-encoder.html'

  auto_updates true
  depends_on cask: 'adobe-creative-cloud'
  depends_on formula: 'https://raw.githubusercontent.com/mklement0/fileicon/master/fileicon.rb'

  paths = {
            StagingFolder:   "#{staged_path}/1",
            INSTALLDIR:      "#{appdir}/#{name.first}",
            AdobeCommon:     ADOBE_COMMON,
            UserPreferences: USER_PREFERENCES = "#{Dir.home}/Library/Preferences".freeze,
            UserDocuments:   USER_DOCUMENTS = "#{Dir.home}/Documents".freeze,
          }

  resolve = ->(path) { path.to_s.sub(%r{\[(\w+)\]}) { paths[Regexp.last_match[1].to_sym] } }

  hdpim = { # .db
            InstallDir:             paths[:INSTALLDIR],
            AppLaunch:              "[INSTALLDIR]/#{name.first}.app/Contents/MacOS/#{name.first}",
            BaseVersion:            version.major_minor,
            Platform:               'osx10-64',
            InstallLang:            language,
            LatestInstalledVersion: version.major_minor,
            Name:                   'Media Encoder',
            BuildVersion:           version.before_comma,
          }

  preflight do
    zip = "#{staged_path}/products/#{sap_code}/AdobeMediaEncoder#{version.major}AllTrial.zip"
    system '/usr/bin/ditto', '-xk', zip, staged_path
    FileUtils.rm zip
  end

  postflight do # Resolve listed file paths.
    pimx = Nokogiri::XML File.read "#{staged_path}/AdobeMediaEncoder#{version.major}AllTrial.pimx"

    assets = pimx.xpath('//Asset').map do |asset|
      source = resolve.call asset[:source]
      target = resolve.call asset[:target]
      [source, target]
    end

    assets.map do |source, target| # Install listed files.
      system_command '/bin/mkdir', args: ['-p', File.dirname(target)], sudo: true
      system_command '/bin/mv',    args: [source, target],             sudo: true
    end

    # Apply suite folder icon.
    icon = pimx.xpath('//FolderIcon/*/text()').map(&resolve)
    system_command "#{HOMEBREW_PREFIX}/bin/fileicon", args: ['set', *icon]

    # Update CC database to recognise installed app.
    insert = "INSERT INTO main.product_installation_%s (SAPCode, ProductVersion, ProcessorFamily, %s) VALUES ('#{sap_code}', '#{version.major_minor}', '64Bit', '%s');"
    sql = Array                     format insert, 'info',      'Status',     1
    sql += hdpim.map { |key, value| format insert, 'meta_info', 'Key, Value', "#{key}', '#{value}" }

    system_command '/usr/bin/sqlite3', args: ['-bail', "#{ADOBE_COMMON}/caps/hdpim.db", sql.join], sudo: true

    FileUtils.rm_r Dir["#{staged_path}/*/"]
    set_ownership [ADOBE_COMMON, "#{USER_PREFERENCES}/Adobe", "#{USER_DOCUMENTS}/Adobe"]
  end

  uninstall_preflight do
    if Dir.exist? staged_path # Remove listed files.
      pimx = Nokogiri::XML File.read "#{staged_path}/AdobeMediaEncoder#{version.major}AllTrial.pimx"
      target = pimx.xpath('//Asset/@target').map(&resolve)
      system_command '/bin/rm', args: ['-rf', *target[2..-3], target.first], sudo: true
    end

    # Remove app from CC database.
    expand = `echo {package,product}_installation{_meta,}_info`.chomp.split ' '
    expand.map do |info|
      system_command '/usr/bin/sqlite3', args: ['-bail', "#{ADOBE_COMMON}/caps/hdpim.db", "DELETE FROM main.#{info} WHERE SAPCode = '#{sap_code}'"], sudo: true
    end
  end

  bundle_id = "com.adobe.#{sap_code.downcase}.application.CC#{version.major}"
  uninstall signal: [['KILL', bundle_id]],
            delete: [
                      "/Applications/Utilities/Adobe Installers/Uninstall #{name.first}",
                      "#{ADOBE_COMMON}/HelpCfg/[a-z][a-z]_[A-Z][A-Z]/MediaEncoder_#{version.major}.[0-9].helpcfg",
                      "#{ADOBE_COMMON}/Installers/*Xml/#{sap_code}_#{version.major}_[0-9]*_AdobeMediaEncoder#{version.major}AllTrial_#{version.major}.[0-9]*.pimx",
                      "#{ADOBE_COMMON}/Uninstall/#{sap_code}_#{version.major}_[0-9]*.*",
                      "#{ADOBE_COMMON}/PCF/?#{sap_code}-#{version.major}.[0-9]*-64-ADBEADBEADBEADBEADBE*.V[0-9]*AdobeMediaEncoder-#{version.major}-Mac-GM.xml",
                      "~#{ADOBE_COMMON}/*/*/CC_MEDIA ENCODER_#{version.major}.[0-9]*.*",
                      '/Users/Shared/Adobe/InstalledCodecs',
                    ],
            trash:  "~/Library/Application Support/CrashReporter/#{name.first}_*.plist",
            rmdir:  [
                      '/Applications/Utilities/Adobe Installers',
                      "#{ADOBE_COMMON}/Media Encoder/{#{version.major}.[0-9],}",
                      "#{ADOBE_COMMON}/Keyfiles/{AdobeMediaEncoder/{#{version.major}.[0-9],},}",
                      "#{ADOBE_COMMON}/HelpCfg/{[a-z][a-z]_[A-Z][A-Z],}",
                      "~#{ADOBE_COMMON}/Extension Manager CC/EM Store/#{sap_code}",
                      '/Users/Shared/Adobe',
                    ]

  zap trash: [
               "~#{ADOBE_COMMON}/Common/Media Cache *",
               "~/Library/Caches/Adobe/Adobe Media Encoder/#{version.major}.[0-9]",
               "~/Library/{Caches,WebKit}/#{bundle_id}",
               "#{USER_PREFERENCES}/#{bundle_id}.plist",
               "#{USER_PREFERENCES}/com.Adobe.Adobe Media Encoder.#{version.major}.[0-9].plist",
               "/{#{USER_PREFERENCES},#{USER_DOCUMENTS}}/Adobe/Adobe Media Encoder/#{version.major}.[0-9]",
               "#{USER_DOCUMENTS}/Adobe/Lumetri",
             ],
      rmdir: [
               "~#{ADOBE_COMMON}/{Common,}",
               "/{#{Dir.home}/Library/Caches,#{USER_PREFERENCES},#{USER_DOCUMENTS}}/Adobe/{Adobe Media Encoder,}",
               "#{USER_DOCUMENTS}/Adobe",
             ]
end
