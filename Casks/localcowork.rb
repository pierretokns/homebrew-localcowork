cask "localcowork" do
  version "0.1.0"
  sha256 arm:   "PLACEHOLDER_ARM64",
         intel: "PLACEHOLDER_X86_64"

  arch arm: "aarch64-apple-darwin", intel: "x86_64-apple-darwin"

  url "https://github.com/pierretokns/cookbook/releases/download/localcowork-v#{version}/LocalCowork_#{version}_#{arch}.dmg"
  name "LocalCowork"
  desc "On-device AI agent by Liquid AI, powered by LFM2 via llama.cpp"
  homepage "https://github.com/Liquid4All/cookbook/tree/main/examples/localcowork"

  livecheck do
    url "https://github.com/pierretokns/cookbook/releases"
    regex(/localcowork[._-]v?(\d+(?:\.\d+)+)/i)
    strategy :github_latest
  end

  depends_on formula: "llama.cpp"
  depends_on macos: ">= :monterey"

  app "LocalCowork.app"

  caveats <<~EOS
    LocalCowork requires the LFM2-24B-A2B model (~14 GB) to function.

    Download the model:
      pip install huggingface-hub
      huggingface-cli download LiquidAI/LFM2-24B-A2B-GGUF LFM2-24B-A2B-Q4_K_M.gguf --local-dir ~/Models

    Start the model server before launching the app:
      llama-server --model ~/Models/LFM2-24B-A2B-Q4_K_M.gguf \\
        --port 8080 --ctx-size 32768 --n-gpu-layers 99 --flash-attn

    This is a community package of Liquid AI's open-source project.
    Source: https://github.com/Liquid4All/cookbook/tree/main/examples/localcowork
  EOS

  zap trash: [
    "~/.localcowork",
    "~/Library/Application Support/com.localcowork.app",
    "~/Library/Caches/com.localcowork.app",
    "~/Library/Preferences/com.localcowork.app.plist",
    "~/Library/Saved Application State/com.localcowork.app.savedState",
  ]
end
