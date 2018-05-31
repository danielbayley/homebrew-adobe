cask 'explode-shape-layers' do
  version :latest
  sha256 :no_check

  # aescripts.com was verified as official when first introduced to the cask
  url 'https://aescripts.com/downloadable/download/sample/sample_id/327',
      user_agent: :fake
  name 'Explode Shape Layers'
  homepage "https://zacklovatt.com/portfolio/#{token}"

  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts/ScriptUI Panels'].max

  plugin = 'zl_ExplodeShapeLayers.jsxbin'
  postflight do
    FileUtils.mv Dir["#{staged_path}/zl_ExplodeShapeLayers_v*/#{plugin}"][0], folder
  end

  support = '~/Library/Application Support'
  uninstall delete: ["#{folder}/#{plugin}", "#{support}/Aescripts/zl_ExplodeShapeLayers"],
            rmdir:  "#{support}/Aescripts"

  caveats "A license can be purchased at https://aescripts.com/#{token}."
end
