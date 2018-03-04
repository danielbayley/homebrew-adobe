cask 'hose-maker' do
  version '10'
  sha256 '07869ad6b735474c393922cd47963314fbb3ae98937f1dccc0b519b87749782c'

  url "https://battleaxe.co/s/Hose-Maker_#{version}.zip"
  name 'Hose Maker'
  homepage 'http://battleaxe.co/rh2-addons'

  depends_on cask: 'rubberhose'

  folder = '/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts/'
  latest = Dir[folder].sort { |min, max| min <=> max }[-1]
  script = 'Hose Maker.jsx'

  artifact script, target: "#{latest}/#{script}"

  uninstall delete: folder + script
end
