cask 'ae-preset-rubberhose-steve-kirby' do
  version '2'
  sha256 '2bc4ca8d11fcc9e198b4680dcb874d8eb4db889afe904138f996f5520233356a'

  url "https://battleaxe.co/s/SteveKirby_RubberHose#{version}_Styles.zip"
  name 'Steve Kirby pack'
  homepage "https://battleaxe.co/rh#{version}-addons#steve-kirby"

  depends_on cask: 'rubberhose'

  root = File.expand_path '~/Library/Application Support/BattleAxe'
  folder = "#{root}/RubberHose #{version}/Styles"

  artifact 'SK_Bodybuilder.ffx', target: "#{folder}/SK_Bodybuilder.ffx"
  artifact 'SK_Electric.ffx', target: "#{folder}/SK_Electric.ffx"
  artifact 'SK_Footballer.ffx', target: "#{folder}/SK_Footballer.ffx"
  artifact 'SK_Robot.ffx', target: "#{folder}/SK_Robot.ffx"
  artifact 'SK_T-Rex.ffx', target: "#{folder}/SK_T-Rex.ffx"
  artifact 'SK_Woodcutter.ffx', target: "#{folder}/SK_Woodcutter.ffx"
  artifact 'SK_Wrangler.ffx', target: "#{folder}/SK_Wrangler.ffx"

  uninstall rmdir: root
end
