cask 'ouroboros' do
  version '2.0.2'
  sha256 '093f971a6dad4670a4da361e854dc104e31ee5ad40a05a6dd5c94ba3391fe470'

  # dropbox.com/s/9uv7vu4amz80eek was verified as official when first introduced to the cask
  url "https://dropbox.com/s/9uv7vu4amz80eek/ouroboros_#{version}.zip?dl=1"
  name 'Ouroboros'
  homepage 'https://georegulus.com/tools'

  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts/ScriptUI Panels'].max

  plugin = 'Ouroboros.jsxbin'
  artifact plugin, target: "#{folder}/#{plugin}"

  uninstall delete: '~/Library/Application Support/Ouroboros'

  caveats do
    free_license "https://aescripts.com/ouroboros-#{version.major}"
    'Please consider a voluntary purchase if you like this plugin.'
  end
end
