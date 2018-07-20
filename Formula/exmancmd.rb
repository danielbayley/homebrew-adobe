class Exmancmd < Formula
  desc "Install add-ons and extensions for Adobe apps"
  homepage "https://www.adobeexchange.com/resources/28"
  url "https://adobe.com/go/ExManCmdMac"
  version "7.4.0.88"
  sha256 "6a20d9a4ad606a0f8e481db80ee5c37da367e2d31f4ebff2a1bc283bec36deec"

  bottle :unneeded

  def install
    libexec.install Dir["Contents/*"]
    bin.install_symlink libexec/"MacOS/ExManCmd"
  end

  test do
    system bin/"ExManCmd", "--help"
  end
end
