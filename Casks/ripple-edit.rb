cask 'ripple-edit' do
  version :latest
  sha256 :no_check

  # aescripts.com was verified as official when first introduced to the cask
  url 'https://aescripts.com/downloadable/download/sample/sample_id/682',
      user_agent: :fake
  name 'Ripple Edit'
  homepage 'https://plugineverything.com/ripple-edit'

  depends_on cask: 'exmancmd'

  postflight do
    zxp = Dir["#{staged_path}/Ripple Edit v*/Ripple Edit.zxp"].max
    system_command "#{HOMEBREW_PREFIX}/bin/exmancmd", args: ['--install', zxp]
  end

  uninstall script: {
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd",
                      args:       ['--remove', 'com.plugineverything.rippleedit'],
                    }

  caveats 'A license can be purchased at https://aescripts.com/ripple-edit.'
end
