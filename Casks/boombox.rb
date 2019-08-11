cask 'boombox' do
  version '1.0.1'
  sha256 'b395f282514caca70aaac1c0f5b19c3e07f057b43240bd676170693fd7ba88a7'

  url "https://mtmograph.com/s/boombox-#{version.no_dots}-mac-ccjy.zip"
  name 'Boombox'
  homepage 'https://mtmograph.com/boombox'

  auto_updates true
  depends_on cask: 'exmancmd'

  installer script: { # pkg "boombox-#{version}-mac/Boombox Installer.pkg"
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd",
                      args:       ['--install', "#{staged_path}/boombox-#{version}-mac/Boombox.zxp"],
                    }

  uninstall script: { # pkgutil: 'com.mtmograph.boombox'
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd",
                      args:       ['--remove', 'com.mtmograph.boombox'],
                    }

  zap       delete: '~/Library/Application Support/boomboxstable'

  caveats "A license can be purchased at https://gumroad.com/l/mtmo_#{token}."
end
