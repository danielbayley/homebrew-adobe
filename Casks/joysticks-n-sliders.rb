cask 'joysticks-n-sliders' do
  version :latest
  sha256 :no_check

  url 'https://aescripts.com/downloadable/download/sample/sample_id/405',
      user_agent: :fake
  name "Joysticks 'n Sliders"
  homepage 'https://aescripts.com/joysticks-n-sliders'

  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts/ScriptUI Panels'].max

  plugin = 'Joysticks_n_Sliders.jsxbin'
  postflight do
    FileUtils.mv Dir["#{staged_path}/Joysticks_n_Sliders_v*/#{plugin}"][0], folder
  end

  uninstall delete: [
                      "#{folder}/#{plugin}",
                      '~/Library/Application Support/Aescripts/JoysticksnSliders',
                    ],
            rmdir:  '~/Library/Application Support/Aescripts'

  caveats "A license can be purchased at https://aescripts.com/#{token}."
end
