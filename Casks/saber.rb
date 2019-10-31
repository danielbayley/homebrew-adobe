cask 'saber' do
  version '1.0.39,2018'
  sha256 '8223f8c014dfa30a25223eaf393921f10e5a39dbc1251069f45c9c906a86c848'

  # vcproducts.s3.amazonaws.com/free/saber was verified as official when first introduced to the cask
  url "https://vcproducts.s3.amazonaws.com/free/saber/SaberInstaller_#{version.before_comma}_Mac_#{version.after_comma}.zip"
  name 'Saber'
  homepage 'https://videocopilot.net/tutorials/saber_plug-in'

  folder = Dir["#{appdir}/Adobe After Effects *"].max
  artifact 'SaberInstaller.app/Contents/Resources/Saber.plugin',
           target: "#{folder}/Plug-ins/VideoCopilot/Saber.plugin"

  uninstall rmdir: "#{folder}/Plug-ins/VideoCopilot"
end
