cask 'ray-dynamic-color' do
  version :latest
  sha256 :no_check

  # aescripts.com was verified as official when first introduced to the cask
  url 'https://aescripts.com/downloadable/download/sample/sample_id/450',
      user_agent: :fake
  name 'Ray Dynamic Color'
  homepage 'https://georegulus.com/tools'

  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts/ScriptUI Panels'].max
  plugin = 'Ray Dynamic Color.jsxbin'

  postflight do
    FileUtils.mv Dir["#{staged_path}/Ray Dynamic Color_v*/#{plugin}"][0], "#{folder}/#{plugin}"
  end

  support = '~/Library/Application Support'
  uninstall delete: ["#{folder}/#{plugin}", "#{support}/Aescripts/Ray"],
            rmdir:  "#{support}/Aescripts"

  zap trash: "#{support}/com.aescripts.SVDRDC*.lic"

  caveats "A license can be purchased at https://aescripts.com/#{token}."
end
