# Homebrew Tap for LocalCowork

On-device AI assistant powered by [LFM2-24B-A2B](https://liquid.ai) from Liquid AI. No cloud, no data leaving your machine.

## Install

```bash
brew tap pierretokns/localcowork
brew install --cask localcowork
```

## Prerequisites

1. **llama.cpp** (installed automatically as a dependency):
   ```bash
   brew install llama.cpp
   ```

2. **LFM2-24B-A2B model** (~14 GB download):
   ```bash
   pip install huggingface-hub
   huggingface-cli download LiquidAI/LFM2-24B-A2B-GGUF LFM2-24B-A2B-Q4_K_M.gguf --local-dir ~/Models
   ```

## Usage

1. Start the model server:
   ```bash
   llama-server --model ~/Models/LFM2-24B-A2B-Q4_K_M.gguf \
     --port 8080 --ctx-size 32768 --n-gpu-layers 99 --flash-attn
   ```

2. Launch LocalCowork from Applications or:
   ```bash
   open -a LocalCowork
   ```

## About

LocalCowork is an open-source desktop agent from [Liquid AI](https://liquid.ai) that runs entirely on-device. It handles 75 tools across 14 MCP servers for file automation, security scanning, document processing, and more.

- Source: [Liquid4All/cookbook](https://github.com/Liquid4All/cookbook/tree/main/examples/localcowork)
- License: MIT
