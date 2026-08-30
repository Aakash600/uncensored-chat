# Uncensored Local LLM Chat (Codespace)

ChatGPT-style UI (**Open WebUI**) + genuinely uncensored GGUF (**Gemma-3-4B-abliterated**), all local in your Codespace. No API, no keys, free, no provider filters.

## Stack
- `llama-server` (prebuilt llama.cpp) → `:8090` — runs the abliterated GGUF
- `open-webui` → `:8080` — ChatGPT-style web UI, wired to llama-server

## Model
- `mradermacher/gemma3-4b-it-abliterated-GGUF` `Q4_K_M` (~2.5 GB)
- Uncensored via **abliteration** (refusal layer removed). Local inference only — nothing leaves the machine.
- Measured on the 4-core/16GB codespace: **~12 tok/s** (4 threads). Prompt ~17 t/s.

## Setup (auto on codespace create)
`.devcontainer/setup.sh` — needs **ubuntu-24.04 base** (glibc 2.39; the prebuilt llama.cpp binary won't run on the older universal 20.04 image). Installs llama.cpp + Open WebUI (`--break-system-packages`, PEP 668).

## Run
```bash
bash download-model.sh   # once: pull the ~2.5GB GGUF into ~/models
bash start-server.sh     # llama-server :8090 (4 threads)
bash start-webui.sh      # open-webui :8080  -> OPENAI_API_BASE_URL=http://127.0.0.1:8090/v1
```
Then open forwarded `localhost:8080`. First visit = create local admin account (stored in codespace only), select model `gemma3-4b-abliterated`.

## Dev notes / gotchas
- Port forward persists as a background process: `gh codespace ports forward <name> 8080:8080`.
- Codespace **rebuild wipes /home** — rerun setup after rebuild.
- `HF_HOME=/root/.hf` error in webui log is harmless (embedded RAG embedder only); chat unaffected.
- Swap model: edit `MODEL` in `start-server.sh` + repo/filename in `download-model.sh` to another abliterated GGUF that fits 16GB.
