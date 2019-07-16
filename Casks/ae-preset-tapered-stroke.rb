cask 'ae-preset-tapered-stroke' do
  version '1.0.2'
  sha256 '03500b99d0feed2007ad4d0de009627c84f9fa87f88ef58d2bc30ddc4cd09bae'

  # sommediaprod.s3.amazonaws.com was verified as official when first introduced to the cask
  url "https://static.schoolofmotion.com/50c63144-82a6-4fdd-92d4-c1126f276290/TaperedStroke_v#{version.major_minor}_v#{version.patch}.zip"
  name 'Tapered Stroke'
  homepage 'https://schoolofmotion.com/tutorials/free-tapered-stroke-after-effects'

  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects */Presets'].max

  preset = "TaperedStroke_v#{version.major_minor}.ffx"
  artifact preset, target: "#{folder}/#{preset}"
end
