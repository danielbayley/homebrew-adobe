cask 'limber' do
  version :latest
  sha256 :no_check

  url 'https://aescripts.com/downloadable/download/sample/sample_id/592',
      user_agent: :fake
  name 'Limber'
  homepage 'https://aescripts.com/limber'

  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts/ScriptUI Panels'].max

  plugin = 'Limber.jsxbin'
  postflight do
    FileUtils.mv Dir["#{staged_path}/Limber_*/#{plugin}"][0], folder
  end

  support = '~/Library/Application Support'
  uninstall delete: ["#{folder}/#{plugin}", "#{support}/Aescripts/Limber"],
            rmdir:  "#{support}/Aescripts"

  zap delete: "#{support}/com.aescripts.SKL.lic"

  caveats "A license can be purchased at #{homepage}."
end
