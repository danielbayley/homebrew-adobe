class Exmancmd < Formula
  desc "Install add-ons and extensions for Adobe apps"
  homepage "https://www.adobeexchange.com/resources/28"
  url "https://www.adobe.com/go/ExManCmdMac"
  version "7.3.4.597"
  sha256 "4a8d0740ba49365391ed7e31ccf6dee9d918b99e86720cf74770f93cd2b094ac"

  bottle :unneeded

  def install
    libexec.install Dir["Contents/*"]
    bin.install_symlink libexec/"MacOS/ExManCmd"
  end

  test do
    system bin/"ExManCmd", "--help"
  end
end
