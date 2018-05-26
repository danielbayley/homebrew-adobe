cask 'duik' do
  version '15.52'
  sha256 'fb845576de6a5b029f40a5426181582c1c06ba3bffba34eea157a7906cb4b364'

  language('en', default: true) { nil }
  language('de') { 'de' }
  language('es') { 'es' }
  language('fr') { 'fr' }
  language('pl') { 'pl' }
  language('zh') { 'zh_HANS' }

  # github.com/Rainbox-dev was verified as official when first introduced to the cask
  url "https://github.com/Rainbox-dev/Duik-#{version.major}/releases/download/v#{version[0...-1]}/Duik_#{version[0...-1]}.zip"
  appcast "https://github.com/Rainbox-dev/Duik-#{version.major}/releases.atom",
          checkpoint: '0ca13b8bfff61e31a474b5614b875cb3575577fc07193f9699eca15af621ac56'
  name 'Duik'
  homepage 'https://rainboxprod.coop/tools/duik'

  panels = 'Scripts/ScriptUI Panels'
  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects *'].max
  files = [
            'Duik.jsx',
            'Duik_images.jsxinc',
            'libduik.jsxinc',
            'Duik_translations.jsxinc',
          ]

  preflight do
    xml = "#{folder}/#{File.basename folder}.app/Contents/Resources/PresetEffects.xml"
    system "cat #{staged_path}/Duik_presetEffects.xml >> '#{xml}'" if language
  end

  files.push "Duik_translations_#{language}.jsxinc" if language
  files.each { |file| artifact file, target: "#{folder}/#{panels}/#{file}" }

  uninstall_postflight do
    data = File.read xml
    restore = data.sub %r{<!-- BEGIN DUIK[\S\s]+}, ''
    File.write xml, restore.chomp
  end

  uninstall delete: '~/Library/Application Support/Duduf/DuIK'

  caveats <<~EOS
    Please consider a donation if you like this plugin.
      https://rainboxprod.coop/tools/#don
  EOS
end
