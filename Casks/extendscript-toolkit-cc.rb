cask 'extendscript-toolkit-cc' do
  version '4.0.0.1'
  sha256 '7111bb197f77eecf518b22f7a6f269647abc17eda4aaed9ba50212462b9848ed'

  language('cs')                { 'cs_CZ' }
  language('da')                { 'da_DK' }
  language('de')                { 'de_DE' }
  language('en-AE')             { 'en_AE' }
  language('en-GB')             { 'en_GB' }
  language('en-IL')             { 'en_IL' }
  language('en', default: true) { 'en_US' }
  language('en-XM')             { 'en_XM' }
  language('es')                { 'es_ES' }
  language('es-LA')             { 'es_LA' }
  language('es-MX')             { 'es_MX' }
  language('es-NA')             { 'es_NA' }
  language('fi')                { 'fi_FI' }
  language('fr-CA')             { 'fr_CA' }
  language('fr')                { 'fr_FR' }
  language('fr-MA')             { 'fr_MA' }
  language('fr-XM')             { 'fr_XM' }
  language('hu')                { 'hu_HU' }
  language('it')                { 'it_IT' }
  language('ja')                { 'ja_JP' }
  language('ko')                { 'ko_KR' }
  language('nb')                { 'nb_NO' }
  language('nl')                { 'nl_NL' }
  language('pl')                { 'pl_PL' }
  language('pt')                { 'pt_BR' }
  language('ru')                { 'ru_RU' }
  language('sv')                { 'sv_SE' }
  language('tr')                { 'tr_TR' }
  language('uk')                { 'uk_UA' }
  language('zh')                { 'zh_CN' }
  language('zh-TW')             { 'zh_TW' }

  url "http://prdl-download.adobe.com/ExtendScriptToolkit/85C17E5FC8B34A7B8483796F0367F97C/1509443413689/AdobeExtendScriptToolkit_#{version.major}_LS22.dmg"
  name 'Adobe ExtendScript Toolkit CC'
  homepage 'https://helpx.adobe.com/download-install/kb/creative-cloud-apps-download.html'

  media_signature = '135274B3-69EE-4AE8-ACCE-1718A1EBC8CC'

  preflight do
    IO.write "#{staged_path}/install.xml", <<~EOS
      <?xml version="1.0" encoding="utf-8"?>
      <Deployment>
        <Properties>
          <Property name="installLanguage">#{language}</Property>
        </Properties>
        <Payloads>
          <Payload adobeCode="{#{media_signature}}">
            <Action>install</Action>
          </Payload>
        </Payloads>
      </Deployment>
    EOS

    system_command "#{staged_path}/Install.app/Contents/MacOS/Install",
                   args: ['--mode=silent', "--deploymentFile=#{staged_path}/install.xml"],
                   sudo: true
  end

  uninstall_preflight do
    IO.write "#{staged_path}/uninstall.xml", <<~EOS
      <?xml version="1.0" encoding="utf-8"?>
      <Deployment>
        <Properties>
          <Property name="removeUserPrefs">0</Property>
          <Property name="mediaSignature">{#{media_signature}}</Property>
        </Properties>
        <Payloads>
          <Payload adobeCode="{#{media_signature}}">
            <Action>remove</Action>
          </Payload>
        </Payloads>
      </Deployment>
    EOS

    system_command "#{staged_path}/Install.app/Contents/MacOS/Install",
                   args: ['--mode=silent', "--deploymentFile=#{staged_path}/uninstall.xml"],
                   sudo: true
  end

  uninstall rmdir: '/Applications/Utilities/Adobe Installers'
end
