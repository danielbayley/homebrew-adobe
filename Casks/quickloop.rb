cask 'quickloop' do
  version '1.0'
  sha256 '9f2d9424c2b575b0b0aaaea8f2796b6e2bf15fdb694dfca3d4512439433a576c'

  # dropbox.com/s/mfgun9ob7aubqkg was verified as official when first introduced to the cask
  url "https://dropbox.com/s/mfgun9ob7aubqkg/Quickloop_v#{version}.zip?dl=1"
  name 'Quickloop'

  link = homepage "https://gumroad.com/l/#{token}"

  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts/ScriptUI Panels'].max
  plugin = 'Quickloop.jsx'

  artifact plugin, target: "#{folder}/#{plugin}"

  caveats do
    free_license link
    'Please consider a voluntary purchase if you like this plugin.'
  end
end
