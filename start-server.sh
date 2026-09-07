#!/usr/bin/env bash
export HOME=/home/vscode
export PATH=/home/vscode/llama.cpp/llama-b10549:/home/vscode/.local/bin:/usr/local/bin:/usr/bin:/bin
MODEL=/home/vscode/models/gemma-4-E4B-it-uncensored-Q4_K_M.gguf
CTX=32768
pkill -9 -f llama-server 2>/dev/null; sleep 3
setsid nohup llama-server -t 4 -tb 4 -m "$MODEL" -c $CTX -ctk q4_0 -ctv q4_0 --reasoning off -n 1024 --host 127.0.0.1 --port 8090 --alias gemma-4-E4B-uncensored > /home/vscode/llama-server.log 2>&1 &
echo server pid $!