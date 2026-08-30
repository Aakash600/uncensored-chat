#!/usr/bin/env bash
set -euxo pipefail
export HOME="${HOME:-/root}"
export PATH="$HOME/.local/bin:$PATH"

# Python tooling (bare ubuntu-24.04 base, vscode user has sudo)
sudo apt-get update -qq
sudo apt-get install -y -qq python3 python3-pip python3-venv openssl curl 2>&1 | tail -2

# llama.cpp prebuilt (matches glibc 2.39 / Ubuntu 24.04)
LLAMA_TAG=b10549
mkdir -p "$HOME/llama.cpp"
cd "$HOME/llama.cpp"
curl -fsSL -o llama.tar.gz \
  "https://github.com/ggml-org/llama.cpp/releases/download/b${LLAMA_TAG}/llama-b${LLAMA_TAG}-bin-ubuntu-x64.tar.gz"
tar xzf llama.tar.gz && rm llama.tar.gz
for b in llama-server llama-cli llama-bench; do ln -sf llama-b${LLAMA_TAG}/\$b ./\$b; done
echo 'export PATH="$HOME/llama.cpp:$PATH"' >> "$HOME/.bashrc"

# Open WebUI + HF tooling (user site-packages)
python3 -m pip install --user --no-cache-dir open-webui huggingface_hub hf_transfer 2>&1 | tail -2

echo "SETUP_DONE"
