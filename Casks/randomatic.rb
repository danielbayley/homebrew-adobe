cask 'randomatic' do
  version '1.1'
  sha256 '6fc1b9c54ee9136936a32b42a6e1254b4e60a4f64d8ef44811ce793f03b74928'

  # dropbox.com/s/to1fqufkp3d2q3h was verified as official when first introduced to the cask
  url "https://dropbox.com/s/to1fqufkp3d2q3h/randomatic_#{version}.zip?dl=1"
  name 'Randomatic'
  homepage 'https://aescripts.com/randomatic'

  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts/ScriptUI Panels'].max
  plugin = 'Randomatic.jsxbin'

  artifact plugin, target: "#{folder}/#{plugin}"
  artifact 'Randomatic', target: "#{folder}/Randomatic"

  caveats do
    free_license 'https://aescripts.com/randomatic'
    'Please consider a voluntary purchase if you like this plugin.'
  end
end
