cask 'midas' do
  version '2.0.2'
  sha256 '2768bba5e03af41fac0265eabe5287cbfdc08145bcc2b120e174764ef1fbfc26'

  url "https://dl.mtmograph.com/midas/latest/midas-#{version}-macos.zip"
  name 'Midas'
  homepage 'https://mtmograph.com/midas'

  auto_updates true
  depends_on formula: 'exmancmd'

  installer script: { # pkg 'INSTALL MIDAS.pkg'
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd",
                      args:       ['--install', "#{staged_path}/midas.zxp"],
                    }

  uninstall script: { # pkgutil: 'com.mtmograph.midas'
                      executable: "#{HOMEBREW_PREFIX}/bin/exmancmd",
                      args:       ['--remove', 'com.mtmograph.midas'],
                    }

  caveats "A license can be purchased at https://gumroad.com/l/mtmo_#{token}."
end
