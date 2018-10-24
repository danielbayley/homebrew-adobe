class Exmancmd < Formula
  desc "Install add-ons and extensions for Adobe apps"
  homepage "https://www.adobeexchange.com/resources/28"
  url "https://adobe.com/go/ExManCmdMac"
  version "7.5.0.79"
  sha256 "bf092874723f1a61c7ca76db0a9f75a8a65ae805ef6568cf54c8189b6c40b507"

  bottle :unneeded

  def install
    libexec.install Dir["Contents/*"]
    bin.install_symlink libexec/"MacOS/ExManCmd"
  end

  test do
    assert_match version.to_s, shell_output("otool -P #{bin}/ExManCmd")
  end
end
