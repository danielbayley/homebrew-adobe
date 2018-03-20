cask 'overlord' do
  version '1.12'
  sha256 'a39a5e333f1aa334f2080bab388ef138d879a7addab4de3952b2784af1bf4512'

  # dropbox.com/s was verified as official when first introduced to the cask
  url "https://dropbox.com/s/#{ENV['HOMEBREW_ADOBE_OVERLORD']}/Overlord-#{version}.zip?dl=1"
  name 'Overlord'
  homepage 'http://battleaxe.co/overlord'

  # auto_updates true
  depends_on formula: 'exmancmd'

  installer script: {
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd", # /01. Updatable Version/Overlord.zxp
                      args:       ['--install', "#{staged_path}/Overlord-#{version}/02. Stable Version/Overlord-stable.zxp"],
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
