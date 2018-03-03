cask 'duik' do
  version '15.52'
  sha256 '4713f40d8d284e8eafa2830234a0f61314de5188bddfa7fb0386736145306926'

  language('en', default: true) { nil }
  language('de') { 'de' }
  language('es') { 'es' }
  language('fr') { 'fr' }
  language('pl') { 'pl' }
  language('zh') { 'zh_HANS' }

  url "https://rainboxprod.coop/downloads/duik/Duik_#{version}.zip"
  name 'Duik'
  homepage 'https://rainboxprod.coop/tools/duik'

  panels = 'Scripts/ScriptUI Panels'
  folder = '/Applications/Adobe Creative Cloud/Adobe After Effects */'
  latest = Dir[folder].sort { |min, max| min <=> max }[-1]
  files = [
            'Duik.jsx',
            'Duik_images.jsxinc',
            'libduik.jsxinc',
            'Duik_translations.jsxinc',
          ]

  preflight do
    xml = "#{latest}/#{File.basename latest}.app/Contents/Resources/PresetEffects.xml"
    system "cat #{staged_path}/Duik_presetEffects.xml >> '#{xml}'" if language
  end

  files.push "Duik_translations_#{language}.jsxinc" if language
  files.each { |file| artifact file, target: "#{latest}/#{panels}/#{file}" }

  uninstall_postflight do
    data = File.read xml
    restore = data.sub %r{<!-- BEGIN DUIK[\S\s]+}, ''
    File.write xml, restore.chomp
  end

  uninstall delete: [
                      "#{folder + panels}/*[Dd]uik*.jsx*",
                      '~/Library/Application Support/Duduf/DuIK',
                    ]

  caveats <<~EOS
    Please consider a donation if you like this plugin.
      https://rainboxprod.coop/tools/#don
  EOS
end
