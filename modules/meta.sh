#!/bin/bash
# ============================================================================
# Module: Meta
# Description: Ghee shortcuts and utilities for Meta.
# ============================================================================

# Meta

_GG_REGISTRY["G"]="G [cmd] or G -a <alias> <cmd> ||| Ghee hot-doc shell"]
_GG_REGISTRY["gheelp"]="print reference table ||| Full command reference"]

G() {
    local script_dir="${_GHEE_DIR}"
    if [ -z "$script_dir" ]; then
        script_dir="${HOME}/ghee"
    fi
    if [ -f "$script_dir/ghee-venv/bin/python" ]; then
        "$script_dir/ghee-venv/bin/python" "$script_dir/ghee.py" "$@"
    else
        python3 "$script_dir/ghee.py" "$@"
    fi
    # Reload custom aliases after adding one
    if [ "$1" = "-a" ]; then
        _ghee_load_custom_aliases
    fi
    # Unalias after removing one
    if [ "$1" = "-rm" ] && [ -n "$2" ]; then
        unalias "$2" 2>/dev/null
    fi
}

# ── gheelp: print formatted reference table ──
gheelp() {
    local section="$1"
    echo -e "${_gg_bold}${_gg_magenta}  ghee command reference${_gg_reset}"
    echo -e "${_gg_dim}  ────────────────────────────────────────────────────────────────${_gg_reset}"
    local key
    for key in $(echo "${!_GG_REGISTRY[@]}" | tr ' ' '\n' | sort); do
        _gg_parse_entry "${_GG_REGISTRY[$key]}"
        # If filtering by section keyword
        if [ -n "$section" ]; then
            local lkey="${key,,}" lsec="${section,,}" ldesc="${_gg_entry_desc,,}" lcmd="${_gg_entry_cmd,,}"
            if [[ "$lkey" != *"$lsec"* && "$ldesc" != *"$lsec"* && "$lcmd" != *"$lsec"* ]]; then
                continue
            fi
        fi
        printf "  ${_gg_green}%-18s${_gg_reset} ${_gg_dim}%-45s${_gg_reset} %s\n" "$key" "$_gg_entry_cmd" "$_gg_entry_desc"
    done
    echo ""
    echo -e "  ${_gg_dim}Tip: ${_gg_cyan}G 'some command'${_gg_dim} to find the best shortcut${_gg_reset}"
    echo -e "  ${_gg_dim}Tip: ${_gg_cyan}G -a olist 'ollama list'${_gg_dim} to add your own${_gg_reset}"
    echo -e "  ${_gg_dim}Tip: ${_gg_cyan}gheelp docker${_gg_dim} to filter by section${_gg_reset}"
}

