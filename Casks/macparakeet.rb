cask "macparakeet" do
  version "0.5.7"
  sha256 "6188cf45f272e24679e8bf49e0c4860c800355b827743c386c785ccdff2166f6"

  url "https://downloads.macparakeet.com/MacParakeet.dmg"
  name "MacParakeet"
  desc "Local STT, transcription, and meeting recording — Parakeet on the Neural Engine"
  homepage "https://macparakeet.com"

  livecheck do
    url "https://macparakeet.com/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "MacParakeet.app"

  zap trash: [
    "~/Library/Application Support/MacParakeet",
    "~/Library/Caches/com.macparakeet",
    "~/Library/Logs/MacParakeet",
    "~/Library/Preferences/com.macparakeet.plist",
    "~/Library/Saved Application State/com.macparakeet.savedState",
  ]
end
