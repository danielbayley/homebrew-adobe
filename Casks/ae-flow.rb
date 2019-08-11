cask 'ae-flow' do
  version :latest
  sha256 :no_check

  # aescripts.com was verified as official when first introduced to the cask
  url 'https://aescripts.com/downloadable/download/sample/sample_id/454',
      user_agent: :fake
  name 'Flow'
  homepage 'https://zacklovatt.com/tools/flow'

  depends_on cask: 'exmancmd'

  postflight do
    zxp = Dir["#{staged_path}/flow-v*/Flow v*/Flow.zxp"].max
    system_command "#{HOMEBREW_PREFIX}/bin/exmancmd", args: ['--install', zxp]
  end

  uninstall script: {
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd",
                      args:       ['--remove', 'Flow'],
                    }

  zap delete: '~/Library/Application Support/com.aescripts.flow.lic'

  caveats 'A license can be purchased at https://aescripts.com/flow.'
end
