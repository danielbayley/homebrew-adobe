cask 'joysticks-n-sliders' do
  version :latest
  sha256 :no_check

  url 'https://aescripts.com/downloadable/download/sample/sample_id/405',
      user_agent: :fake
  name "Joysticks 'n Sliders"
  homepage 'https://aescripts.com/joysticks-n-sliders'

  folder = '/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts/ScriptUI Panels/'
  latest = Dir[folder].sort { |min, max| min <=> max }[-1]

  plugin = 'Joysticks_n_Sliders.jsxbin'
  postflight do
    FileUtils.mv Dir["#{staged_path}/Joysticks_n_Sliders_v*/#{plugin}"][0], latest
  end

  uninstall delete: [
                      folder + plugin,
                      '~/Library/Application Support/Aescripts/JoysticksnSliders',
                    ],
            rmdir:  '~/Library/Application Support/Aescripts'

  caveats "A license can be purchased at https://aescripts.com/#{token}."
end
