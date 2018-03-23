cask 'fx-console' do
  version '1.0.2,2018'
  sha256 'c2cccfb619b57611498116512e3a8a07d86cfb135756f6424d30f55babf4dbc3'

  # vcproducts.s3.amazonaws.com was verified as official when first introduced to the cask
  url "http://vcproducts.s3.amazonaws.com/free/fxconsole/FXConsoleInstaller_#{version.before_comma}_Mac_#{version.after_comma}.zip"
  name 'FX Console'
  homepage 'https://videocopilot.net/blog/?s=fx+console'

  container nested: "FXConsoleInstaller_#{version.before_comma}_Mac.dmg"

  folder = '/Applications/Adobe Creative Cloud/Adobe After Effects *'
  latest = Dir[folder].sort { |min, max| min <=> max }[-1]

  plugin = 'FXConsole.plugin'
  artifact "FXConsoleInstaller.app/Contents/Resources/#{plugin}",
           target: "#{latest}/Plug-ins/VideoCopilot/#{plugin}"

  rmdir = [
            '~/Documents/VideoCopilot',
            '/Library/Application Support/VideoCopilot',
            "#{latest}/Plug-ins/VideoCopilot",
          ]

  uninstall rmdir: rmdir

  zap trash: [
               rmdir[0] + '/FXConsole',
               rmdir[1] + '/effects_*',
             ],
      rmdir: rmdir
end
