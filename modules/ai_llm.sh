#!/bin/bash
# ============================================================================
# Module: Ai Llm
# Description: Ghee shortcuts and utilities for Ai Llm.
# ============================================================================

# AI / LLM CLI Tools

_GG_REGISTRY["ollrun"]="ollama run MODEL|||Run a local LLM model via Ollama"
_GG_REGISTRY["ollmls"]="ollama list ||| List locally downloaded Ollama models"
_GG_REGISTRY["ollpull"]="ollama pull MODEL ||| Download an Ollama model"
_GG_REGISTRY["ollamaserv"]="ollama serve ||| Start Ollama API server on port 11434"
_GG_REGISTRY["llmchat"]="curl localhost:11434/api/generate with JSON ||| Chat with local Ollama model via curl"
_GG_REGISTRY["tokcount"]="python3 -c tiktoken count tokens ||| Count tokens in a string (requires tiktoken)"
_GG_REGISTRY["openai"]="curl api.openai.com/v1/chat/completions ||| Send a prompt to OpenAI API via curl"

# 400. Run LLM model (Ollama)
alias ollmls='ollama list'
alias ollamaserv='ollama serve'
alias ollpull='ollama pull'

ollama_run() {
    if [ -z "$1" ]; then
        echo "Usage: ollama_run <model> (e.g. ollama_run llama3)"
        return 1
    fi
    ollama run "$1"
}

# 401. Chat with a local Ollama model via curl (non-interactive)
llmchat() {
    local model="${2:-llama3}"
    if [ -z "$1" ]; then
        echo "Usage: llmchat 'your question here' [model]"
        return 1
    fi
    curl -s http://localhost:11434/api/generate \
        -d "{\"model\":\"$model\",\"prompt\":\"$1\",\"stream\":false}" \
        | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('response',''))"
}

# 402. Count tokens in a string (requires: pip install tiktoken)
tokcount() {
    if [ -z "$1" ]; then echo "Usage: tokcount 'your string here'"; return 1; fi
    python3 -c "
import tiktoken, sys
enc = tiktoken.get_encoding('cl100k_base')
tokens = enc.encode('$1')
print(f'{len(tokens)} tokens')
" 2>/dev/null || echo "Install tiktoken: pip install tiktoken"
}

# 403. Send a prompt to OpenAI API
openai_ask() {
    if [ -z "$1" ]; then echo "Usage: openai_ask 'prompt' [model]"; return 1; fi
    local model="${2:-gpt-4o-mini}"
    curl -s https://api.openai.com/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d "{\"model\":\"$model\",\"messages\":[{\"role\":\"user\",\"content\":\"$1\"}]}" \
        | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['choices'][0]['message']['content'])"
}

# Ollama model management
_GG_REGISTRY["ollmrm"]="ollama rm MODEL ||| Remove an Ollama model"
_GG_REGISTRY["ollmcp"]="ollama cp SRC DEST ||| Copy/clone an Ollama model"
_GG_REGISTRY["ollmps"]="ollama ps ||| Show running Ollama models"
_GG_REGISTRY["ollmcr"]="ollama create MODEL -f Modelfile ||| Create custom Ollama model"
_GG_REGISTRY["ollmshow"]="ollama show MODEL ||| Show model details/parameters"

alias ollmrm='ollama rm'
alias ollmcp='ollama cp'
alias ollmps='ollama ps'
alias ollmcr='ollama create'
alias ollmshow='ollama show'
