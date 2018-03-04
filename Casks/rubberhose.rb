cask 'rubberhose' do
  version '2.08'
  sha256 '2a574e1cc347d64afbcb1fe76dd0aa21290b9f6ca72bb13050c6fd50218bae2e'

  # dropbox.com/s was verified as official when first introduced to the cask
  url "https://dropbox.com/s/#{ENV['HOMEBREW_ADOBE_RUBBERHOSE']}/RubberHose#{version}.zip?dl=1"
  name 'RubberHose'
  homepage 'http://battleaxe.co/rubberhose'

  subfolder = 'Scripts/ScriptUI Panels'
  folder = "/Applications/Adobe Creative Cloud/Adobe After Effects */#{subfolder}/"
  plugin = 'RubberHose.jsxbin'

  latest = Dir[folder].sort { |min, max| min <=> max }[-1]

  artifact "RubberHose#{version}/RubberHose#{version.major}.jsxbin",
           target: "#{latest}/#{plugin}"

  uninstall delete: [
                      folder + plugin,
                      "~/Library/Preferences/Adobe/After Effects/*/#{subfolder}/#{plugin}",
                    ]

  zap trash: "~/Library/Application Support/BattleAxe/RubberHose #{version.major}",
      rmdir: '~/Library/Application Support/BattleAxe'

  caveats <<~EOS
    Cask requires a HOMEBREW_ADOBE_RUBBERHOSE environment variable to be set
    with the unique portion of the download url to your saved copy on Dropbox.
    A license can be purchased at https://gumroad.com/l/#{token},
    and then saved to your Dropbox account from your Gumroad Library.
  EOS
end
