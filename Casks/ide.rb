cask 'ide' do
  version '0.0.2'
  sha256 '054ead29c7d1aea9e2a566c78532d0d277ac02b8f820347f10d3959e591776ef'

  url "https://github.com/adobe-extension-tools/adobe-ide/releases/download/#{version}/adobe-ide-#{version}.pkg"
  appcast 'https://github.com/adobe-extension-tools/adobe-ide/releases.atom',
          checkpoint: '7445f09971b2abf2d8341b3f77542b74abba838e1f4ab78f62971001a6cafa54'
  name 'Adobe IDE'
  homepage 'https://github.com/adobe-extension-tools/adobe-ide'

  pkg "adobe-ide-#{version}.pkg", allow_untrusted: true

  uninstall pkgutil: 'com.aet.adobeide'
end
