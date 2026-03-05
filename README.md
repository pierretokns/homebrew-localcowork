# Homebrew Tap for LocalCowork

Community-maintained Homebrew cask for [LocalCowork](https://github.com/Liquid4All/cookbook/tree/main/examples/localcowork), an open-source on-device AI agent built by [Liquid AI](https://liquid.ai).

LocalCowork runs the LFM2-24B-A2B language model locally via llama.cpp, dispatching tool calls across 14 MCP servers with ~390ms latency and zero cloud dependencies. All processing stays on your machine.

> **Note:** This is an unofficial community tap packaging Liquid AI's open-source LocalCowork project (MIT licensed). It is not maintained by or affiliated with Liquid AI.

## Install

```bash
brew tap pierretokns/localcowork
brew install --cask localcowork
```

This installs the LocalCowork desktop app and automatically pulls in [llama.cpp](https://github.com/ggml-org/llama.cpp) as a dependency.

## Model Setup

LocalCowork requires the LFM2-24B-A2B model (~14 GB) to function. The app itself is just the shell; the model provides the intelligence.

```bash
pip install huggingface-hub
huggingface-cli download LiquidAI/LFM2-24B-A2B-GGUF LFM2-24B-A2B-Q4_K_M.gguf --local-dir ~/Models
```

## Usage

1. Start the model server (keep this running):
   ```bash
   llama-server --model ~/Models/LFM2-24B-A2B-Q4_K_M.gguf \
     --port 8080 --ctx-size 32768 --n-gpu-layers 99 --flash-attn
   ```

2. Launch LocalCowork from Applications or:
   ```bash
   open -a LocalCowork
   ```

## System Requirements

- macOS 12 (Monterey) or later
- Apple Silicon recommended (M1/M2/M3/M4 with 16+ GB unified memory)
- Intel Macs supported but significantly slower
- ~14 GB disk space for the model, ~200 MB for the app

## What LocalCowork Does

LocalCowork is a desktop agent that handles file automation, security scanning, document processing, and system operations through 75 tools across 14 MCP servers. It achieves 80% single-step tool accuracy at sub-second latency on consumer hardware.

Key capabilities: file operations, PII/secrets scanning, document extraction, audit logging, clipboard access, calendar management, task tracking, and more.

See the [full documentation](https://github.com/Liquid4All/cookbook/tree/main/examples/localcowork) for details.

## Links

- Upstream source: [Liquid4All/cookbook/examples/localcowork](https://github.com/Liquid4All/cookbook/tree/main/examples/localcowork)
- Liquid AI blog post: [No-Cloud Tool-Calling Agents on Consumer Hardware](https://liquid.ai/blog/no-cloud-tool-calling-agents-consumer-hardware-lfm2-24b-a2b)
- Model: [LiquidAI/LFM2-24B-A2B-GGUF](https://huggingface.co/LiquidAI/LFM2-24B-A2B-GGUF) on HuggingFace
- License: MIT
