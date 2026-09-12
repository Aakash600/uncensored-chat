#!/usr/bin/env bash
export HOME=/home/vscode
pkill -f llmproxy.py 2>/dev/null; sleep 1
setsid nohup python3 /home/vscode/llmproxy.py > /home/vscode/proxy.log 2>&1 &
echo proxy pid $!