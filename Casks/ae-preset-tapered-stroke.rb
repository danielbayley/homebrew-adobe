cask 'ae-preset-tapered-stroke' do
  version '1.0'
  sha256 '03500b99d0feed2007ad4d0de009627c84f9fa87f88ef58d2bc30ddc4cd09bae'

  # sommediaprod.s3.amazonaws.com was verified as official when first introduced to the cask
  url 'https://sommediaprod.s3.amazonaws.com/284034a4-39a2-4be1-a242-40ebed307582.zip'
  name 'Tapered Stroke'
  homepage 'http://schoolofmotion.com/tutorials/free-tapered-stroke-after-effects'

  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects */Presets'].max

  preset = "TaperedStroke_v#{version}.ffx"
  artifact preset, target: "#{folder}/#{preset}"
end
