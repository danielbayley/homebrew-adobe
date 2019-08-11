cask 'overlord' do
  version '1.20'
  sha256 'fc4fbad3fbada2c58658c4bb76160aacf95df71af022e17daf20cce43ee5a252'

  # dropbox.com/s was verified as official when first introduced to the cask
  url "https://dropbox.com/s/#{ENV['HOMEBREW_ADOBE_OVERLORD']}/Overlord-#{version}.zip?dl=1"
  name 'Overlord'
  homepage 'https://battleaxe.co/overlord'

  depends_on cask: 'exmancmd'

  installer script: {
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd",
                      args:       ['--install', "#{staged_path}/Overlord-#{version}/Overlord.zxp"],
                    }

  uninstall script: {
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd",
                      args:       ['--remove', 'Overlord'],
                    }

  zap trash: '~/Library/Application Support/BattleAxe/Overlord',
      rmdir: '~/Library/Application Support/BattleAxe'

  caveats <<~EOS
    Cask requires a HOMEBREW_ADOBE_OVERLORD environment variable to be set
    with the unique portion of the download url to your saved copy on Dropbox.
    A license can be purchased at https://gumroad.com/l/#{token},
    and then saved to your Dropbox account from your Gumroad Library.
  EOS
end
