#!/usr/bin/env bash
# Start Open WebUI :8080, wired to llama-server. Run from codespace home.
export HOME="${HOME:-/root}"
export PATH="$HOME/.local/bin:$PATH"
export OPENAI_API_BASE_URL="http://127.0.0.1:8090/v1"
export OPENAI_API_KEY="local"

pkill -f open-webui 2>/dev/null; sleep 2
nohup open-webui serve --host 0.0.0.0 --port 8080 \
  > "$HOME/open-webui.log" 2>&1 &
echo "open-webui pid $!"
