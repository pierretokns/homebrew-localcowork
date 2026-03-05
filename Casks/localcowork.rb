cask "localcowork" do
  version "0.1.0"
  sha256 arm:   "PLACEHOLDER_ARM64",
         intel: "PLACEHOLDER_X86_64"

  arch arm: "aarch64-apple-darwin", intel: "x86_64-apple-darwin"

  url "https://github.com/pierretokns/cookbook/releases/download/localcowork-v#{version}/LocalCowork_#{version}_#{arch}.dmg"
  name "LocalCowork"
  desc "On-device AI assistant powered by LFM2, no cloud dependency"
  homepage "https://github.com/Liquid4All/cookbook/tree/main/examples/localcowork"

  livecheck do
    url "https://github.com/pierretokns/cookbook/releases"
    regex(/localcowork[._-]v?(\d+(?:\.\d+)+)/i)
    strategy :github_latest
  end

  depends_on formula: "llama.cpp"
  depends_on macos: ">= :monterey"

  app "LocalCowork.app"

  postflight do
    ohai "LocalCowork installed!"
    ohai ""
    ohai "You need the LFM2-24B-A2B model (~14 GB) to run LocalCowork."
    ohai "Download it with:"
    ohai "  pip install huggingface-hub"
    ohai "  huggingface-cli download LiquidAI/LFM2-24B-A2B-GGUF LFM2-24B-A2B-Q4_K_M.gguf --local-dir ~/Models"
    ohai ""
    ohai "Then start the model server:"
    ohai "  llama-server --model ~/Models/LFM2-24B-A2B-Q4_K_M.gguf --port 8080 --ctx-size 32768 --n-gpu-layers 99 --flash-attn"
  end

  zap trash: [
    "~/.localcowork",
    "~/Library/Application Support/com.localcowork.app",
    "~/Library/Caches/com.localcowork.app",
    "~/Library/Preferences/com.localcowork.app.plist",
    "~/Library/Saved Application State/com.localcowork.app.savedState",
  ]
end
