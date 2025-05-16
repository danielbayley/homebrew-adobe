cask "adobe-illustrator-scripts-hiroyuki-sato" do
  version "2018-07-20"

  language "ja" do
    sha256 "fc156536de9511134160d1c57ed5c910ac0d877537c4ce1b29a34f58d6fb66d0"
    ""
  end
  language "en", default: true do
    sha256 "bcb4c2fbaa29c07cb52f20c034a39da8c9a9868512f49579b0062cfaec6dcfb8"
    "_en"
  end

  author = "Hiroyuki Sato"
  owner  = "shspage"
  domain = "#{owner}.com/aijs"
  tokens = token.split "-"
  app    = tokens.first(2).map(&:capitalize).join " "

  url "http://#{domain}/aics_scripts#{language}.zip"
  name tokens[1..2].map(&:capitalize).join " "
  desc "JavaScript scripts for #{app} CSx"
  homepage "http://#{domain}/#{language.delete_prefix "_"}"

  livecheck do
    regex(/(\d{4}(?:[.-]\d{2}){2})/)
  end

  year = "[0-9]" * 4
  scripts = appdir.glob("#{app} #{year}/Presets.localized/*/Scripts").max
  subpath = File.basename url.uri.path, ".*"

  staged_path.glob("#{subpath}/{*,*/*/*}.jsx").each do |path|
    target = scripts/author/path.basename
    next if path.to_s.include? "_oldUI"

    artifact path, target: target unless target.exist?
  end

  uninstall_preflight do
    receipt = caskroom_path/".metadata/INSTALL_RECEIPT.json"
    json = JSON.load_file receipt, symbolize_names: true if receipt.exist?
    next if json.nil?

    json[:uninstall_artifacts].compact.map do |uninstall|
      path = uninstall[:artifact]&.last&.dig :target
      system_command "/bin/rm", args: [path], sudo: true unless path.nil?
    end
  end

  uninstall rmdir: scripts/author

  caveats do
    doc = staged_path/subpath/"doc"
    license doc/"LICENSE.txt"
    <<~EOS
      Read the manual at:
        #{doc}/README.txt
    EOS
  end
end
