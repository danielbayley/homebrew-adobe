cask 'rubberhose' do
  version '2.09'
  sha256 '0a06703e705b9b70a148742b39559440bcb247c5e63965136c8f83931a8ef83e'

  # dropbox.com/s was verified as official when first introduced to the cask
  url "https://dropbox.com/s/#{ENV['HOMEBREW_ADOBE_RUBBERHOSE']}/RubberHose#{version}.zip?dl=1"
  name 'RubberHose'
  homepage 'https://battleaxe.co/rubberhose'

  folder = Dir['/Applications/Adobe Creative Cloud/Adobe After Effects */Scripts/ScriptUI Panels'].max

  artifact "RubberHose#{version}/RubberHose#{version.major}.jsxbin",
           target: "#{folder}/RubberHose.jsxbin"

  zap trash: "~/Library/Application Support/BattleAxe/RubberHose #{version.major}",
      rmdir: '~/Library/Application Support/BattleAxe'

  caveats <<~EOS
    Cask requires a HOMEBREW_ADOBE_RUBBERHOSE environment variable to be set
    with the unique portion of the download url to your saved copy on Dropbox.
    A license can be purchased at https://gumroad.com/l/#{token},
    and then saved to your Dropbox account from your Gumroad Library.
  EOS
end
