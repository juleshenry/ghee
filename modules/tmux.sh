#!/bin/bash
# ============================================================================
# Module: Tmux
# Description: Ghee shortcuts and utilities for Tmux.
# ============================================================================

# tmux Power User Shortcuts

_GG_REGISTRY["tnew"]="tmux new -s NAME ||| Create a new named tmux session"
_GG_REGISTRY["tls"]="tmux ls ||| List tmux sessions"
_GG_REGISTRY["tat"]="tmux attach -t NAME ||| Attach to a tmux session"
_GG_REGISTRY["tkill"]="tmux kill-session -t NAME ||| Kill a tmux session"
_GG_REGISTRY["tkillall"]="tmux kill-server ||| Kill all tmux sessions"
_GG_REGISTRY["treload"]="tmux source ~/.tmux.conf ||| Reload tmux config"
_GG_REGISTRY["tsplit"]="tmux split-window -h ||| Split tmux pane horizontally"
_GG_REGISTRY["tsplitv"]="tmux split-window -v ||| Split tmux pane vertically"

# Start or attach to a session by name
t() {
    if [ -z "$1" ]; then
        tmux ls 2>/dev/null || echo "No sessions. Start one: t mysession"
        return
    fi
    tmux new-session -A -s "$1"
}

alias tnew='tmux new -s'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tkill='tmux kill-session -t'
alias tkillall='tmux kill-server'
alias treload='tmux source ~/.tmux.conf && echo "tmux config reloaded"'
alias tsplit='tmux split-window -h'
alias tsplitv='tmux split-window -v'
