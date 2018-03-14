cask 'lottie' do
  version '5.1.8'
  sha256 '48a415c8e4ed0fb8d0d511220ac07ff4108c801f2fe14d4817fd09aa89e7f30a'

  # github.com/airbnb/lottie-web was verified as official when first introduced to the cask
  url "https://github.com/airbnb/lottie-web/archive/v#{version}.zip"
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
