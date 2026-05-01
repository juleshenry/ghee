#!/bin/bash
# ghee-functions.sh
# Core functionality and interactive shell wrapper for Ghee

# ============================================================================
# COLORS & FORMATTING
# ============================================================================

_gg_red='\033[0;31m'
_gg_green='\033[0;32m'
_gg_yellow='\033[0;33m'
_gg_blue='\033[0;34m'
_gg_magenta='\033[0;35m'
_gg_cyan='\033[0;36m'
_gg_bold='\033[1m'
_gg_dim='\033[2m'
_gg_reset='\033[0m'

_gg_ok()   { echo -e "${_gg_green}${_gg_bold}[ok]${_gg_reset} $*"; }
_gg_info() { echo -e "${_gg_cyan}[..]${_gg_reset} $*"; }
_gg_warn() { echo -e "${_gg_yellow}[!!]${_gg_reset} $*"; }
_gg_err()  { echo -e "${_gg_red}[ERR]${_gg_reset} $*" >&2; }

# ============================================================================
# GHEE CMD REGISTRY & PYTHON RUNNER
# ============================================================================

# Detect script directory
if [ -n "$ZSH_VERSION" ]; then
    export _GHEE_DIR="$(dirname "${(%):-%x}")"
elif [ -n "$BASH_VERSION" ]; then
    export _GHEE_DIR="$(dirname "${BASH_SOURCE[0]}")"
else
    export _GHEE_DIR="${PWD}"
fi

# Use `typeset -A` for zsh or `declare -A` for bash globally
if [ -n "$ZSH_VERSION" ]; then
    typeset -A _GG_REGISTRY
else
    declare -A _GG_REGISTRY 2>/dev/null || true
fi

_GG_CUSTOM_FILE="${HOME}/.ghee-custom"

# Load custom aliases from ~/.ghee-custom as real shell aliases
_ghee_load_custom_aliases() {
    if [ -f "$_GG_CUSTOM_FILE" ]; then
        while IFS= read -r line || [ -n "$line" ]; do
            [ -z "$line" ] && continue
            local a="${line%%|||*}"
            local rest="${line#*|||}"
            local c="${rest%%|||*}"
            a="$(printf '%s\n' "$a" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
            c="$(printf '%s\n' "$c" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
            [ -z "$a" ] || [ -z "$c" ] && continue
            # Only create alias if alias name is a single word (valid alias)
            if [[ "$a" =~ ^[a-zA-Z_][a-zA-Z0-9_-]*$ ]]; then
                alias "$a"="$c"
            fi
        done < "$_GG_CUSTOM_FILE"
    fi
}

_ghee_load_custom_aliases

# Detect alias conflicts across modules (call after all modules are sourced)
_ghee_check_conflicts() {
    local mod_dir="${_GHEE_DIR}/modules"
    [ -d "$mod_dir" ] || return
    if [ -n "$ZSH_VERSION" ]; then
        typeset -A _seen
    else
        declare -A _seen 2>/dev/null || true
    fi
    local key mod
    for mod in "$mod_dir"/*.sh; do
        local modname="$(basename "$mod" .sh)"
        while IFS= read -r key; do
            [ -z "$key" ] && continue
            if [ -n "${_seen[$key]+x}" ]; then
                _gg_warn "Alias conflict: '${key}' defined in ${_seen[$key]} and ${modname}"
            fi
            _seen["$key"]="$modname"
        done < <(grep -o '_GG_REGISTRY\["[^"]*"\]' "$mod" 2>/dev/null | sed 's/_GG_REGISTRY\["//;s/"\]//')
    done
}

g() {
    local script_dir="${_GHEE_DIR}"
    local _ghee_python
    if [ -f "$script_dir/ghee-venv/bin/python" ]; then
        _ghee_python="$script_dir/ghee-venv/bin/python"
    elif [ -f "$script_dir/ghee-venv/Scripts/python.exe" ]; then
        _ghee_python="$script_dir/ghee-venv/Scripts/python.exe"
    else
        _ghee_python="python3"
    fi

    # Run the Python CLI tool
    "$_ghee_python" "$script_dir/ghee.py" "$@"
    
    # Reload custom aliases after adding one
    if [ "$1" = "-a" ]; then
        _ghee_load_custom_aliases
    fi
    # Unalias after removing one
    if [ "$1" = "-rm" ] && [ -n "$2" ]; then
        unalias "$2" 2>/dev/null
    fi
}

# ============================================================================
# TAB COMPLETION
# ============================================================================

if [ -n "$ZSH_VERSION" ]; then
    _ghee_completions() {
        local -a subcmds
        # Added '-q' alias for '-o'
        subcmds=('-a:Add a custom shortcut' '-rm:Remove a custom shortcut' 'ls:List custom shortcuts' '-o:Ask Ollama AI' '-q:Ask Ollama AI' '--sync:Sync from Gist' 'info:Show module aliases' 'update:Self-update ghee' '--help:Show help')
        _describe 'G commands' subcmds
    }
    compdef _ghee_completions G
    compdef _ghee_completions g
elif [ -n "$BASH_VERSION" ]; then
    _ghee_completions() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        # Added '-q' alias for '-o'
        COMPREPLY=($(compgen -W "-a -rm ls -o -q --sync info update --help" -- "$cur"))
    }
    complete -F _ghee_completions G
    complete -F _ghee_completions g
fi
