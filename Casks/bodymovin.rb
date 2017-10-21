cask 'bodymovin' do
  version '4.13.0'
  sha256 '0bcb0b9a93fb3c8410b5de3e69c6436dc5d68da4c57d6cb82d424c133cef9fdd'

  url "https://github.com/bodymovin/bodymovin/archive/v#{version}.zip"
  appcast 'https://github.com/bodymovin/bodymovin/releases.atom',
          checkpoint: 'e089056ecc1c8829a757a14f5dd0b565576bbc0894dba82e5561222c9a99e3b0'
  name 'Bodymovin'
  homepage 'https://github.com/bodymovin/bodymovin'

  depends_on formula: 'exmancmd'

  installer script: {
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd",
                      args:       ['--install', "#{staged_path}/bodymovin-#{version}/build/extension/bodymovin.zxp"],
                    }

  uninstall script: {
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd",
                      args:       ['--remove', 'com.bodymovin.bodymovin'],
                    }
end
