#!/usr/bin/env bash
export HOME=/home/vscode
export PATH=/home/vscode/.local/bin:/usr/local/bin:/usr/bin:/bin

# Chat history location (SQLite)
export DATA_DIR=/home/vscode/webui-data

# Web search (DuckDuckGo, keyless)
export ENABLE_WEB_SEARCH=true
export WEB_SEARCH_ENGINE=duckduckgo
export WEB_SEARCH_RESULT_COUNT=5
export ENABLE_WEB_SEARCH_CONFIRMATION=false

# llama-server backend
export OPENAI_API_BASE_URL=http://127.0.0.1:8090/v1
export OPENAI_API_KEY=local

pkill -f open-webui 2>/dev/null; sleep 2
nohup open-webui serve --host 0.0.0.0 --port 8080 > /home/vscode/open-webui.log 2>&1 &
echo webui pid $!
