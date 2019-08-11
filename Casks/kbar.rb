cask 'kbar' do
  version :latest
  sha256 :no_check

  url 'https://aescripts.com/downloadable/download/sample/sample_id/677',
      user_agent: :fake
  name 'KBar'
  homepage 'https://aescripts.com/kbar'

  depends_on cask: 'exmancmd'

  postflight do
    zxp = Dir["#{staged_path}/kbar-*.zxp"][0]
    system_command "#{HOMEBREW_PREFIX}/bin/exmancmd", args: ['--install', zxp]
  end

  uninstall script: {
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd",
                      args:       ['--remove', 'KBar'],
                    }

  zap trash: '~/Library/Application Support/com.aescripts.KBar.lic'

  caveats "A license can be purchased at #{homepage}."
end
