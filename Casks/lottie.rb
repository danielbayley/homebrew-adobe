cask 'lottie' do
  version '5.1.9'
  sha256 '00a15f3520780b18f9a1f0d45660729d70799d247e9c8fec25cdf711def88282'

  # github.com/airbnb/lottie-web was verified as official when first introduced to the cask
  url "https://github.com/airbnb/lottie-web/archive/v#{version}.zip"
  name 'Lottie'
  homepage 'https://airbnb.io/lottie'

  depends_on cask: 'exmancmd'

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
