cask 'gradient-hose' do
  version '1.0'
  sha256 '97992fa041084bd811f06162b4ffc3df62cae3f7425cd5b66c5c7436c8e713e5'

  url 'http://battleaxe.co/s/GradientHose_Style.zip'
  name 'Gradient Hose'
  homepage 'http://battleaxe.co/rh2-addons'

  depends_on cask: 'rubberhose'

  folder = '~/Library/Application Support/BattleAxe/RubberHose */Styles/'
  preset = 'Gradient Hose.ffx'

  artifact preset, target: "#{Dir[File.expand_path folder][0]}/#{preset}"

  uninstall delete: folder + preset,
            rmdir:  '~/Library/Application Support/BattleAxe'
end
