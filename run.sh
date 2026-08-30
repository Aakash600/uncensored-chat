#!/usr/bin/env bash
# Uncensored local LLM chat stack — bring everything up.
# llama-server :8090 (GGUF)  +  Open WebUI :8080 (UI). Run from codespace home.
set -euo pipefail
export HOME="${HOME:-/root}"
export PATH="$HOME/llama.cpp/llama-b10549:$HOME/.local/bin:$PATH"

bash "$HOME/start-server.sh"
bash "$HOME/start-webui.sh"

echo "waiting for llama-server ..."
sleep 15
curl -s http://127.0.0.1:8090/health && echo
echo "Open WebUI: http://localhost:8080"
