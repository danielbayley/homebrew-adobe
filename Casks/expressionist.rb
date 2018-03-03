cask 'expressionist' do
  version :latest
  sha256 :no_check

  # aescripts.com was verified as official when first introduced to the cask
  url 'https://aescripts.com/downloadable/download/sample/sample_id/411',
      user_agent: :fake
  name 'Expressionist'
  homepage 'http://klustre.nl/expressionist'

  depends_on formula: 'exmancmd'

  postflight do
    zxp = Dir["#{staged_path}/Expressionist */Mac/Expressionist-*.zxp"][0]
    system_command "#{HOMEBREW_PREFIX}/bin/exmancmd", args: ['--install', zxp]
  end

  uninstall script: {
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd",
                      args:       ['--remove', 'Expressionist'],
                    }

  zap delete: '~/Library/Preferences/com.aescripts.Expressionist.lic'

  caveats "A license can be purchased at https://aescripts.com/#{token}."
end
