#!/usr/bin/env bash
# Download the abliterated GGUF model into ~/models
set -euo pipefail
export HOME="${HOME:-/root}"
export PATH="$HOME/.local/bin:$PATH"
MODEL_DIR="$HOME/models"
mkdir -p "$MODEL_DIR"
python3 - <<'PY'
import os
from huggingface_hub import hf_hub_download
repo="mradermacher/gemma3-4b-it-abliterated-GGUF"
fname="gemma3-4b-it-abliterated.Q4_K_M.gguf"
p=hf_hub_download(repo_id=repo, filename=fname, local_dir=os.path.expanduser("~/models"), local_dir_use_symlinks=False)
print("OK", p)
PY
echo "MODEL_READY"
