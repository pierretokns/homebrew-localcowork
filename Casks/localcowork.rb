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

  # --- Hardware constraints (from Liquid AI PRD) ---
  # LFM2-24B-A2B Q4_K_M requires ~14.5 GB for inference.
  # Minimum: M1 Pro / 16 GB unified memory
  # Recommended: M2 Pro+ / 32 GB unified memory
  # Apple Silicon only — Intel Macs lack the unified memory architecture
  # needed for performant local inference of a 24B-parameter model.
  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  # --- Runtime dependencies ---
  # llama.cpp provides llama-server for local model inference
  depends_on formula: "llama.cpp"
  # Node.js 20+ required for TypeScript MCP servers (filesystem, calendar,
  # email, task, data, audit, clipboard, system)
  depends_on formula: "node@22"
  # Python 3.12 required for Python MCP servers (document, ocr, knowledge,
  # meeting, security, screenshot-pipeline)
  depends_on formula: "python@3.12"
  # Tesseract OCR — fallback text extraction when vision model is unavailable
  depends_on formula: "tesseract"

  app "LocalCowork.app"

  postflight do
    # Create config directories
    system_command "/bin/mkdir", args: ["-p",
      "#{Dir.home}/.localcowork/models",
      "#{Dir.home}/.localcowork/templates",
      "#{Dir.home}/.localcowork/trash"]
  end

  caveats <<~EOS
    Hardware requirements (from Liquid AI):
      Minimum:     Apple Silicon M1 Pro with 16 GB unified memory
      Recommended: Apple Silicon M2 Pro or later with 32 GB unified memory
      Intel Macs are not supported.

    LocalCowork requires the LFM2-24B-A2B model (~14 GB) to function.
    The model provides tool-calling intelligence across 75 tools / 14 MCP servers.

    Download the model:
      huggingface-cli download LiquidAI/LFM2-24B-A2B-GGUF \\
        LFM2-24B-A2B-Q4_K_M.gguf --local-dir ~/Models

    If you don't have huggingface-cli:
      pip3 install huggingface-hub

    Start the model server before launching the app:
      llama-server --model ~/Models/LFM2-24B-A2B-Q4_K_M.gguf \\
        --port 8080 --ctx-size 32768 --n-gpu-layers 99 --flash-attn on

    Model details:
      Name:        LFM2-24B-A2B (Liquid Foundation Model 2)
      Parameters:  24B total, 2.3B active per token (64-expert MoE, top-4)
      Quantization: Q4_K_M GGUF (~14 GB on disk, ~14.5 GB in memory)
      Context:     128K tokens (32K recommended for tool-calling)
      Accuracy:    80% single-step tool selection at ~390ms latency
      Source:      https://huggingface.co/LiquidAI/LFM2-24B-A2B-GGUF

    This is a community package of Liquid AI's open-source project (MIT license).
    Source: https://github.com/Liquid4All/cookbook/tree/main/examples/localcowork
  EOS

  zap trash: [
    "~/.localcowork",
    "~/Library/Application Support/com.localcowork.app",
    "~/Library/Caches/com.localcowork.app",
    "~/Library/Preferences/com.localcowork.app.plist",
    "~/Library/Saved Application State/com.localcowork.app.savedState",
    "~/Library/WebKit/com.localcowork.app",
  ]
end
