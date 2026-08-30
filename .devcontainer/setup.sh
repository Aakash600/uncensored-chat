#!/usr/bin/env bash
set -euxo pipefail
export HOME=/home/codespace
export PATH="$HOME/.local/bin:$PATH"

# --- llama.cpp prebuilt binaries (no compile, CPU) ---
LLAMA_TAG=b10549
mkdir -p "$HOME/llama.cpp"
cd "$HOME/llama.cpp"
curl -fsSL -o llama.tar.gz \
  "https://github.com/ggml-org/llama.cpp/releases/download/b${LLAMA_TAG}/llama-b${LLAMA_TAG}-bin-ubuntu-x64.tar.gz"
tar xzf llama.tar.gz
rm llama.tar.gz
echo 'export PATH="$HOME/llama.cpp:$PATH"' >> "$HOME/.bashrc"

# --- Open WebUI (ChatGPT-style UI, OpenAI-compatible client) ---
python3 -m pip install --user --no-cache-dir open-webui 2>&1 | tail -3
export PATH="$HOME/.local/bin:$PATH"

# --- HuggingFace downloader tool ---
python3 -m pip install --user --no-cache-dir huggingface_hub hf_transfer 2>&1 | tail -2

echo "SETUP_DONE"
