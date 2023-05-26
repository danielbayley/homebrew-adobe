cask "adobe-illustrator-scripts-hiroyuki-sato-shanfan-huang" do
  version :latest
  sha256 :no_check

  author = "Hiroyuki Sato"
  owner = "Shanfan"
  repo = "Illustrator-Scripts-Archive"
  repository = "github.com/#{owner}/#{repo}"

  url "https://#{repository}/tarball/master", verified: repository
  name "Adobe Illustrator Scripts by #{author}"
  desc "Scripts to perform vector manipulations in Adobe Illustror"
  homepage "https://#{owner}.github.io/#{repo}"

  scripts = appdir.glob("Adobe Illustrator [0-9][0-9][0-9][0-9]/Presets.localized/*/Scripts").max
  [
    "Adjust Dashes",
    "Adjust Dashes (offset)",
    "Arc Correction",
    "Archimedean Spiral",
    "Arrow-A",
    "Arrow-V",
    "Circle",
    "Circumcircle",
    "Common Tangents",
    "Cut At Selected Anchors",
    "Dance",
    "Divide (length)",
    "Dup At Selected Anchors",
    "Extend Handles",
    "Join Reasonably",
    "Merge Overlapped Anchors",
    "Metaball (Arc)",
    "Metaball",
    "Path Length",
    "Remove Anchors",
    "Reverse",
    "Round Any Corner",
    "Sine Curve",
    "Tangents From A Point",
    "Tree-like",

  ].each do |script|
    script << ".jsx"
    artifact "#{owner}-#{repo}-418b0e0/jsx/#{script}", target: scripts/"#{author}/#{script}"
  end

  uninstall rmdir: scripts/author
end
