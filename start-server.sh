#!/usr/bin/env bash
# Start llama-server :8090 (4 threads). Run from codespace home.
export HOME="${HOME:-/root}"
export PATH="$HOME/llama.cpp/llama-b10549:$PATH"
MODEL="$HOME/models/gemma3-4b-it-abliterated.Q4_K_M.gguf"
CTX=65536   # >=64K for Open WebUI

pkill -f llama-server 2>/dev/null; sleep 2
nohup llama-server \
  -t 4 -tb 4 \
  -m "$MODEL" \
  -c $CTX -ctk q8_0 -ctv q8_0 \
  --host 127.0.0.1 --port 8090 \
  --alias gemma3-4b-abliterated \
  > "$HOME/llama-server.log" 2>&1 &
echo "llama-server pid $!"
