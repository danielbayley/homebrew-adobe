cask 'lottie' do
  version '5.0.3'
  sha256 '59828336c3280f3b05442f7a4b485071b380be49b11d9a5d552059e12c5c83f4'

  # github.com/airbnb/lottie-web was verified as official when first introduced to the cask
  url "https://github.com/airbnb/lottie-web/archive/v#{version}.zip"
  appcast 'https://github.com/airbnb/lottie-web/releases.atom',
          checkpoint: '404ae35db88c57fa8ece65f07963e2ffe6def53c7a77c213e1f6fb4ea5aececb'
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
