#!/usr/bin/env bash
export HOME=/home/vscode
export PATH=/home/vscode/llama.cpp/llama-b10549:/home/vscode/.local/bin:/usr/local/bin:/usr/bin:/bin
MODEL=/home/vscode/models/huihui-qwen3-4b-instruct-2507-abliterated-q4_k_m.gguf
CTX=32768
pkill -9 -f llama-server 2>/dev/null; sleep 5
nohup llama-server -t 4 -tb 4 -m "$MODEL" -c $CTX -ctk q4_0 -ctv q4_0 --reasoning off --host 127.0.0.1 --port 8090 --alias qwen3-4b-abliterated > /home/vscode/llama-server.log 2>&1 &
echo server pid $!
