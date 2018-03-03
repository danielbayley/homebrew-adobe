cask 'ray-dynamic-color' do
  version :latest
  sha256 :no_check

  # aescripts.com was verified as official when first introduced to the cask
  url 'https://aescripts.com/downloadable/download/sample/sample_id/450',
      user_agent: :fake
  name 'Ray Dynamic Color'
  homepage 'http://georegulus.com/'

  subfolder = 'Scripts/ScriptUI Panels'
  folder = "/Applications/Adobe Creative Cloud/Adobe After Effects */#{subfolder}/"
  plugin = 'Ray Dynamic Color.jsxbin'

  postflight do
    FileUtils.mv Dir["#{staged_path}/Ray Dynamic Color_v*/#{plugin}"][0],
                 Dir[folder].sort { |min, max| min <=> max }[-1] + plugin
  end

  uninstall delete: [
                      folder + plugin,
                      '~/Library/Application Support/Aescripts/Ray',
                    ],
            rmdir:  '~/Library/Application Support/Aescripts'

  caveats "A license can be purchased at https://aescripts.com/#{token}."
end
