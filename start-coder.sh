#!/usr/bin/env bash
export HOME=/home/vscode
export PATH=/home/vscode/llama.cpp/llama-b10549:/home/vscode/.local/bin:/usr/local/bin:/usr/bin:/bin
MODEL=/home/vscode/models/DeepSeek-Coder-V2-Lite-Instruct-abliterated.Q4_K_M.gguf
CTX=16384
pkill -9 -f 'llama-server.*8091' 2>/dev/null; sleep 2
setsid nohup llama-server -t 4 -tb 4 -m "$MODEL" -c $CTX -ctk q4_0 -ctv q4_0 -n 1024 --chat-template-file /home/vscode/deepseek2-tpl.json --host 127.0.0.1 --port 8091 --alias deepseek-coder-v2-lite-abliterated > /home/vscode/llama-coder.log 2>&1 &
echo coder pid $!