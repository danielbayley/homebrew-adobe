cask 'limber' do
  version :latest
  sha256 :no_check

  url 'https://aescripts.com/downloadable/download/sample/sample_id/592',
      user_agent: :fake
  name 'Limber'
  homepage 'https://aescripts.com/limber'

  folder = '/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts/ScriptUI Panels/'
  latest = Dir[folder].sort { |min, max| min <=> max }[-1]

  plugin = 'Limber.jsxbin'
  postflight do
    FileUtils.mv Dir["#{staged_path}/Limber_*/#{plugin}"][0], latest
  end

  uninstall delete: [
                      folder + plugin,
                      '~/Library/Application Support/Aescripts/Limber',
                    ],
            rmdir:  '~/Library/Application Support/Aescripts'

  caveats "A license can be purchased at https://aescripts.com/#{token}."
end
