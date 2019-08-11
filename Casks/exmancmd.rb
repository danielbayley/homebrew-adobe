cask 'exmancmd' do
  version :latest
  sha256 :no_check

  # adobe.com/go was verified as official when first introduced to the cask
  url 'https://adobe.com/go/ExManCmdMac'
  name 'ExMan Command Line Tool'
  homepage 'https://www.adobeexchange.com/resources/28'

  binary 'Contents/MacOS/ExManCmd', target: 'exmancmd'
end
