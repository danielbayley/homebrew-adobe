cask 'ray-dynamic-color' do
  version :latest
  sha256 :no_check

  # aescripts.com was verified as official when first introduced to the cask
  url 'https://aescripts.com/downloadable/download/sample/sample_id/450',
      user_agent: :fake
  name 'Ray Dynamic Color'
  homepage 'https://georegulus.com/tools'

  auto_updates true

  folder = '/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts/ScriptUI Panels/'
  latest = Dir[folder].sort { |min, max| min <=> max }[-1]

  plugin = 'Ray Dynamic Color.jsxbin'
  postflight do
    FileUtils.mv Dir["#{staged_path}/Ray Dynamic Color_v*/#{plugin}"][0], latest + plugin
  end

  uninstall delete: [
                      folder + plugin,
                      '~/Library/Application Support/Aescripts/Ray',
                    ],
            rmdir:  '~/Library/Application Support/Aescripts'

  caveats "A license can be purchased at https://aescripts.com/#{token}."
end
