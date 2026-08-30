#!/usr/bin/env bash
# Uncensored local LLM chat stack — restart sequence for the Codespace.
# llama-server :8090  (GGUF backend)   +  Open WebUI :8080  (ChatGPT-style UI)
set -euo pipefail
export HOME="${HOME:-/root}"
export PATH="$HOME/llama.cpp:$HOME/.local/bin:$PATH"
MODEL_DIR="$HOME/models"
MODEL="$MODEL_DIR/gemma3-4b-it-abliterated.Q4_K_M.gguf"
CTX=65536   # >=64K required by Open WebUI

# 1) server
pkill -f llama-server 2>/dev/null || true
nohup llama-server \
  -m "$MODEL" \
  -c $CTX -ctk q8_0 -ctv q8_0 \
  --host 127.0.0.1 --port 8090 \
  --alias gemma-3-4b-abliterated \
  > "$HOME/llama-server.log" 2>&1 &

# 2) webui
pkill -f open-webui 2>/dev/null || true
export OPENAI_API_BASE_URL="http://127.0.0.1:8090/v1"
export OPENAI_API_KEY="local"
nohup open-webui serve --host 0.0.0.0 --port 8080 \
  > "$HOME/open-webui.log" 2>&1 &

echo "waiting for llama-server ..."
sleep 15
curl -s http://127.0.0.1:8090/health || echo "server not up yet"
echo
echo "Open WebUI: http://localhost:8080"
