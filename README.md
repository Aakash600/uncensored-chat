# Uncensored Local LLM Chat (Codespace)

ChatGPT-style UI (**Open WebUI**) + genuinely uncensored GGUF (**Gemma-3-4B-abliterated**), all local, no API, no keys, free.

## Stack
- `llama-server` (prebuilt llama.cpp) → `:8090` — runs the abliterated GGUF
- `open-webui` → `:8080` — ChatGPT-style web UI, wired to llama-server

## Setup (already auto-runs on Codespace create)
`.devcontainer/setup.sh` installs llama.cpp + Open WebUI.

## Run
```bash
bash download-model.sh   # once: pulls the ~2.6GB abliterated GGUF into ~/models
bash run.sh              # starts llama-server (:8090) + open-webui (:8080)
```

Then open the forwarded `localhost:8080`. First login = create a local admin account (stored only in the codespace).

## Model
- Model: `mradermacher/gemma3-4b-it-abliterated-GGUF`, `Q4_K_M` (~2.6 GB)
- Uncensored via abliteration (no refusal layer), local-only inference → no prompts leave the machine, no provider filtering.
- CPU fast on 4-core codespace: ~10+ tok/s.

Swap model: edit `MODEL` in `run.sh` + repo/filename in `download-model.sh` to any abliterated GGUF that fits 16GB (e.g. Qwen-7B-abliterated Q4 ~4.4GB, Llama-3.1-8B Q5 ~5.7GB).
