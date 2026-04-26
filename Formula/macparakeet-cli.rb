class MacparakeetCli < Formula
  desc "Local STT, transcription, and prompt automation for Apple Silicon"
  homepage "https://macparakeet.com"
  url "https://github.com/moona3k/macparakeet/releases/download/cli-v1.0.1/macparakeet-cli-1.0.1-darwin-arm64.tar.gz"
  version "1.0.1"
  sha256 "7bfae3c2fdc539a9630aedfa570b93394ecfedcaaf165cb19c138e6f8158e784"
  license "GPL-3.0-or-later"

  # Apple Silicon only — the Neural Engine is the entire performance story
  depends_on arch: :arm64
  # Runtime media deps (bundled inside MacParakeet.app, but the standalone
  # CLI install needs them on PATH).
  depends_on "ffmpeg"
  # macOS 14.2+ (Sonoma) — required by FluidAudio + Swift 6 runtime.
  # Homebrew's `depends_on macos:` only accepts major-version symbols, so
  # `:sonoma` covers 14.0+; the patch-level floor (14.2) is enforced at
  # install time via the `odie` check below.
  depends_on macos: :sonoma
  depends_on "yt-dlp"

  def install
    odie "macparakeet-cli requires macOS 14.2 or later" if MacOS.version < "14.2"
    bin.install "macparakeet-cli"
  end

  def caveats
    <<~EOS
      First run downloads the Parakeet TDT speech model (~6 GB) to:
        ~/Library/Application Support/MacParakeet/models/

      The CLI shares its database with the macOS app at:
        ~/Library/Application Support/MacParakeet/macparakeet.db

      Verify with:
        macparakeet-cli health --json

      Compatibility policy (semver):
        https://github.com/moona3k/macparakeet/blob/main/Sources/CLI/CHANGELOG.md

      Agent integration docs (OpenClaw, Hermes, generic):
        https://github.com/moona3k/macparakeet/tree/main/integrations
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/macparakeet-cli --version")
  end
end
