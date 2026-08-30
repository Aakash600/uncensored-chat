#!/usr/bin/env bash
# Start llama-server :8090 (4 threads) — Qwen3-4B-abliterated.
# Run from codespace home. Thinking forced off (--reasoning off) for speed.
export HOME="${HOME:-/root}"
export PATH="$HOME/llama.cpp/llama-b10549:$PATH"
MODEL="$HOME/models/huihui-qwen3-4b-instruct-2507-abliterated-q4_k_m.gguf"
CTX=32768   # >=8K fine for chat; web-search prompts can be long

pkill -9 -f llama-server 2>/dev/null; sleep 3
nohup llama-server \
  -t 4 -tb 4 \
  -m "$MODEL" \
  -c $CTX -ctk q4_0 -ctv q4_0 \
  --reasoning off \
  --host 127.0.0.1 --port 8090 \
  --alias qwen3-4b-abliterated \
  > "$HOME/llama-server.log" 2>&1 &
echo "llama-server pid $!"
