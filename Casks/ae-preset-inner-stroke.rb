cask 'ae-preset-inner-stroke' do
  version :latest
  sha256 :no_check

  preset = 'zl_InnerStroke.ffx'
  url "https://zacklovatt.com/presets/#{preset}", user_agent: :fake
  name 'Inner Stroke'
  homepage 'https://zacklovatt.com/preset-shape-layer-inner-stroke'

  container type: :naked

  folder = Dir["#{appdir}/Adobe After Effects */Presets"].max

  artifact preset, target: "#{folder}/#{preset}"
end
