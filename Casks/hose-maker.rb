cask 'hose-maker' do
  version '10'
  sha256 '07869ad6b735474c393922cd47963314fbb3ae98937f1dccc0b519b87749782c'

  url "https://battleaxe.co/s/Hose-Maker_#{version}.zip"
  name 'Hose Maker'
  homepage 'https://battleaxe.co/rh2-addons'

  depends_on cask: 'rubberhose'

  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts'].max

  script = 'Hose Maker.jsx'
  artifact script, target: "#{folder}/#{script}"

  uninstall delete: "#{folder}/#{script}"
end
