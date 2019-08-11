cask 'saber' do
  version '1.0.39,2018'
  sha256 '3ecba4d2f1e658d89aabce57ea4916f034b286814ba87a982242ee7b85b063d2'

  # vcproducts.s3.amazonaws.com/free was verified as official when first introduced to the cask
  url "https://vcproducts.s3.amazonaws.com/free/saber/SaberInstaller_#{version.before_comma}_Mac_#{version.after_comma}.zip"
  name 'Saber'
  homepage 'https://videocopilot.net/blog/?s=saber'

  container nested: "SaberInstaller_#{version.before_comma}_Mac.dmg"

  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects *'].max

  plugin = 'Saber.plugin'
  artifact "SaberInstaller.app/Contents/Resources/#{plugin}",
           target: "#{folder}/Plug-ins/VideoCopilot/#{plugin}"

  uninstall rmdir: "#{folder}/Plug-ins/VideoCopilot"
end
