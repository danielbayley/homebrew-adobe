cask 'auto-crop' do
  version '2.71,2015.3'
  sha256 '67c59586b5f480ed32a8b2d81dc121551509725937287e9bb4a62e4947f2c52c'

  url "https://dropbox.com/s/765pt3421inbotk/autocrop#{version.after_comma}.zip?dl=1"
  name 'Auto Crop'

  link = homepage "https://batchframe.com/tool/#{token}"

  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts/ScriptUI Panels'].max

  artifact "AutoCrop_#{version.after_comma}.jsxbin", target: "#{folder}/Auto Crop.jsxbin"

  caveats do
    free_license link
    'Please consider a voluntary purchase if you like this plugin.'
  end
end
