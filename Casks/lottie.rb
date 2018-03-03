cask 'lottie' do
  version '5.1.7'
  sha256 '5f4250511ce51085a070d2a441bd3b14bfd2a4ffcf839d36b22c9be4abe53736'

  # github.com/airbnb/lottie-web was verified as official when first introduced to the cask
  url "https://github.com/airbnb/lottie-web/archive/v#{version}.zip"
  appcast 'https://github.com/airbnb/lottie-web/releases.atom',
          checkpoint: '86cd017974acfdbfd96bfd12ded367eeedaf81a52c5ab66fc33ab6a2ece79fdd'
  name 'Lottie'
  homepage 'http://airbnb.io/lottie'

  depends_on formula: 'exmancmd'

  installer script: {
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd",
                      args:       ['--install', "#{staged_path}/lottie-web-#{version}/build/extension/bodymovin.zxp"],
                    }

  uninstall script: {
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd",
                      args:       ['--remove', 'com.bodymovin.bodymovin'],
                    }

  caveats 'Lottie remains referenced as Bodymovin within After Effects.'
end
