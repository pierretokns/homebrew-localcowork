# Homebrew Tap for LocalCowork

Community-maintained Homebrew cask for [LocalCowork](https://github.com/Liquid4All/cookbook/tree/main/examples/localcowork), an open-source on-device AI agent built by [Liquid AI](https://liquid.ai).

LocalCowork runs the LFM2-24B-A2B language model locally via llama.cpp, dispatching tool calls across 14 MCP servers with ~390ms latency and zero cloud dependencies. All processing stays on your machine.

> **Note:** This is an unofficial community tap. It is not maintained by or affiliated with Liquid AI.

## Hardware Requirements

From [Liquid AI's PRD](https://github.com/Liquid4All/cookbook/tree/main/examples/localcowork/docs/PRD.md):

| | Minimum | Recommended |
|---|---|---|
| **Chip** | Apple M1 Pro | Apple M2 Pro or later |
| **Memory** | 16 GB unified | 32 GB unified |
| **Disk** | ~15 GB free (model + app) | ~20 GB free |
| **macOS** | 12.0 (Monterey) | 14.0+ (Sonoma) |

**Intel Macs are not supported.** The 24B-parameter model requires Apple Silicon's unified memory architecture for performant local inference.

## Install

```bash
brew tap pierretokns/localcowork
brew install --cask localcowork
```

This automatically installs:
- **llama.cpp** — local model inference server
- **node@22** — TypeScript MCP servers (filesystem, calendar, email, task, data, audit, clipboard, system)
- **python@3.12** — Python MCP servers (document, OCR, knowledge, meeting, security, screenshot-pipeline)
- **tesseract** — fallback OCR engine

## Model Setup

LocalCowork requires the **LFM2-24B-A2B** model (~14 GB) to function.

| Property | Value |
|---|---|
| Name | LFM2-24B-A2B (Liquid Foundation Model 2) |
| Parameters | 24B total, 2.3B active per token |
| Architecture | 64-expert MoE, top-4, 40 layers (1:3 attention:convolution) |
| Quantization | Q4_K_M GGUF |
| Disk size | ~14 GB |
| Memory usage | ~14.5 GB |
| Context window | 128K tokens (32K recommended for tool-calling) |
| Tool accuracy | 80% single-step at ~390ms latency |

```bash
# Install huggingface-cli if you don't have it
pip3 install huggingface-hub

# Download the model
huggingface-cli download LiquidAI/LFM2-24B-A2B-GGUF \
  LFM2-24B-A2B-Q4_K_M.gguf --local-dir ~/Models
```

## Usage

1. Start the model server (keep running in a terminal):
   ```bash
   llama-server --model ~/Models/LFM2-24B-A2B-Q4_K_M.gguf \
     --port 8080 --ctx-size 32768 --n-gpu-layers 99 --flash-attn on
   ```

2. Launch LocalCowork:
   ```bash
   open -a LocalCowork
   ```

## What LocalCowork Does

75 tools across 14 MCP servers:

| Server | Tools | Capabilities |
|---|---|---|
| filesystem | 9 | File CRUD, search, watch |
| document | 8 | Text extraction, conversion, diff, PDF generation |
| security | 6 | PII/secrets scanning, encryption |
| audit | 4 | Audit logs, compliance reports |
| system | 10 | OS info, processes, screenshots |
| clipboard | 3 | OS clipboard access |
| ocr | 4 | Vision model + Tesseract fallback |
| knowledge | 5 | SQLite-vec RAG, semantic search |
| meeting | 4 | Whisper.cpp transcription |
| calendar | 4 | .ics parsing, system calendar |
| email | 5 | MBOX/Maildir parsing, SMTP |
| task | 5 | SQLite task database |
| data | 5 | CSV and database operations |
| screenshot-pipeline | 3 | Capture and UI analysis |

## Links

- Upstream source: [Liquid4All/cookbook/examples/localcowork](https://github.com/Liquid4All/cookbook/tree/main/examples/localcowork)
- Blog post: [No-Cloud Tool-Calling Agents on Consumer Hardware](https://liquid.ai/blog/no-cloud-tool-calling-agents-consumer-hardware-lfm2-24b-a2b)
- Model: [LiquidAI/LFM2-24B-A2B-GGUF](https://huggingface.co/LiquidAI/LFM2-24B-A2B-GGUF) on HuggingFace
- License: MIT
