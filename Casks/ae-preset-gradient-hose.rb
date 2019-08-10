cask 'ae-preset-gradient-hose' do
  version '1.0'
  sha256 '97992fa041084bd811f06162b4ffc3df62cae3f7425cd5b66c5c7436c8e713e5'

  url 'https://battleaxe.co/s/GradientHose_Style.zip'
  name 'Gradient Hose'
  homepage 'https://battleaxe.co/rh2-addons#gradient-hose'

  depends_on cask: 'rubberhose'

  root = File.expand_path '~/Library/Application Support/BattleAxe'
  folder = Dir["#{root}/RubberHose */Styles"][0]

  preset = 'Gradient Hose.ffx'
  artifact preset, target: "#{folder}/#{preset}"

  uninstall rmdir: root
end
