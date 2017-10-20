class Exmancmd < Formula
  desc "Install add-ons and extensions for Adobe apps"
  homepage "https://helpx.adobe.com/creative-cloud/kb/installingextensionsandaddons.html"
  url "https://www.adobeexchange.com/ExManCmd_mac.zip"
  version "7.3.3.481"
  sha256 "9ed5b6dc8c48a1f76fbab87f53aa87e85b5b718f44fa6ce46be12cc3f5880475"

  bottle :unneeded

  def install
    libexec.install Dir["Contents/*"]
    bin.install_symlink libexec/"MacOS/ExManCmd"
  end

  test do
    system bin/"ExManCmd", "--help"
  end
end
