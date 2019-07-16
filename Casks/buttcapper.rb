cask 'buttcapper' do
  version '1.1'
  sha256 'ec0fdeb87ee2f2ba76d04f3965a79f7b32df021e0ab4d8fc0a208239fdb6b693'

  # dropbox.com/s/mgsiyaaz4ncnpu9 was verified as official when first introduced to the cask
  url "https://dropbox.com/s/mgsiyaaz4ncnpu9/ButtCapper_v#{version}.zip?dl=1"
  name 'ButtCapper'
  homepage 'https://battleaxe.co/buttcapper'

  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts'].max
  plugin = 'ScriptUI Panels/ButtCapper.jsxbin'

  artifact "ButtCapper_v#{version}/#{plugin}", target: "#{folder}/#{plugin}"
  artifact "ButtCapper_v#{version}/Headless", target: "#{folder}/ButtCapper_Headless"

  uninstall delete: '~/Library/Application Support/BattleAxe/undefined',
            rmdir:  '~/Library/Application Support/BattleAxe'

  caveats do
    free_license "https://gumroad.com/l/#{token}"
    'Please consider a voluntary purchase if you like this plugin.'
  end
end
