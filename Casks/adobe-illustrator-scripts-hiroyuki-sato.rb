cask "adobe-illustrator-scripts-hiroyuki-sato" do
  version :latest
  sha256 :no_check

  author = "Hiroyuki Sato"
  repo = "illustrator-scripts"
  branch = "master"

  url "https://github.com/shspage/#{repo}/archive/#{branch}.zip"
  name "#{author} Illustrator Scripts"
  desc "JavaScript scripts for Adobe Illustrator CSx"
  homepage "https://github.com/shspage/#{repo}#readme"

  scripts = appdir.glob("Adobe Illustrator [0-9][0-9][0-9][0-9]/Presets.localized/*/Scripts").max
  %w[
    batchTextEdit
    breakDashes
    flatten
    handleGlue
    noiseFill
    noiseRotate
    noiseScale
    notches
    softgel

    etc/dupAlongThePath
    etc/grass
    etc/inscribedCircle
    etc/newLayer(&L)
    etc/ovalize
    etc/resizeToLength
    etc/smoothing

  ].each do |script|
    script << ".jsx"
    target = script.delete_prefix "etc/"
    artifact "#{repo}-#{branch}/#{script}", target: scripts/author/target
  end
end
