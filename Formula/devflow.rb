# Homebrew formula for devflow.
#
# Source of truth lives in the devflow repo at packaging/homebrew/devflow.rb;
# this is the live copy users install via:
#
#     brew install atrivolabs/tap/devflow
#
# Update `url` + `sha256` on every release (see packaging/homebrew/README.md).
class Devflow < Formula
  desc "Focus companion for developers — music, pomodoro, and session flow"
  homepage "https://devflow.fm"
  # Published npm tarball for the scoped package (binary stays `devflow`).
  url "https://registry.npmjs.org/@atrivolabs/devflow/-/devflow-0.1.0.tgz"
  sha256 "2a2a7abe7a840237e1a0c119d690c74cede9f7b4d68e66bf9b56e67880250b29"
  license "MIT"

  depends_on "node"
  # The two system binaries devflow needs at runtime. Declaring them here is the
  # whole point of the brew path: `brew install devflow` pulls them in
  # automatically, so music "just works" with no auto-download step.
  depends_on "mpv"
  depends_on "yt-dlp"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devflow --version")
  end
end
