#!/bin/bash
# ============================================================================
# Module: Shell File Utilities
# Description: Ghee shortcuts and utilities for Shell File Utilities.
# ============================================================================

# Shell / File Utilities

_GG_REGISTRY["h"]="history | grep TERM ||| Grep shell history"]
_GG_REGISTRY["hl"]="history lucky match + exec ||| Run penultimate history match"]
_GG_REGISTRY["dst"]="find . -name '.DS_Store' -exec rm ||| Remove .DS_Store files recursively"]
_GG_REGISTRY["dust-kash"]="find . -name '*.kash' -exec rm ||| Remove .kash cache files recursively"]
_GG_REGISTRY["date-file-maker"]="touch MM-DD-YY-HH:MM:SS.txt ||| Create a UTC-timestamped file"]
_GG_REGISTRY["swap"]="mv file1 tmp && mv file2 file1 && mv tmp file2 ||| Swap names of two files"]
_GG_REGISTRY["mkcd"]="mkdir -p DIR && cd DIR ||| mkdir + cd in one step"]
_GG_REGISTRY["extract"]="tar/unzip/7z/etc ||| Universal archive extractor"]
_GG_REGISTRY["tre"]="tree -I '.git|node_modules' ||| tree with junk dirs ignored"]
_GG_REGISTRY["ports"]="lsof -iTCP -sTCP:LISTEN ||| Show listening TCP ports"]
_GG_REGISTRY["sizeof"]="du -sh PATH ||| Human-readable size of file/dir"]
_GG_REGISTRY["blk"]="python3 -m black FILE ||| Run Python Black formatter"]
_GG_REGISTRY["serve"]="python3 -m http.server PORT ||| Quick HTTP server"]
_GG_REGISTRY["jql"]="jq -C '.' FILE | less -R ||| Pretty-print JSON with less"]
_GG_REGISTRY["rmdstore"]="find . -name '.DS_Store' -delete ||| Remove .DS_Store with feedback"]
_GG_REGISTRY["rmnodemodules"]="find+rm node_modules ||| Interactively remove node_modules dirs"]
_GG_REGISTRY["countext"]="find . -type f | sed/sort/uniq ||| Count files by extension"]
_GG_REGISTRY["findlarge"]="find . -type f -size +N ||| Find files larger than N"]

# h: grep shell history
# Usage: h searchterm
h() {
    if [ -z "$1" ]; then
        _gg_err "Usage: h <searchterm>"
        return 1
    fi
    history 1 | grep --color=auto "$1"
}

# hl: history-grep "I'm feeling lucky" prompt
# Usage: hl searchterm
hl() {
    if [ -z "$1" ]; then
        _gg_err "Usage: hl <searchterm>"
        return 1
    fi
    local result
    result=$(history 1 | grep "$1" | tail -n 2 | head -n 1)
    if [ -z "$result" ]; then
        _gg_warn "No matches for '$1'"
        return 1
    fi
    echo -e "${_gg_cyan}Penultimate match:${_gg_reset} $result"
    read -p "Press Enter to execute, or Ctrl+C to cancel..."
    eval "$result"
}

# dst: Remove all .DS_Store files recursively
dst() {
    local count
    count=$(find . -type f -name '.DS_Store' 2>/dev/null | wc -l | tr -d ' ')
    find . -type f -name '.DS_Store' -exec rm {} +
    _gg_ok "Removed $count .DS_Store file(s)."
}

# dust-kash: Remove all .kash cache files recursively
dust-kash() {
    local count
    count=$(find . -type f -name '*.kash' 2>/dev/null | wc -l | tr -d ' ')
    find . -type f -name '*.kash' -exec rm {} +
    _gg_ok "Removed $count .kash file(s)."
}

# date-file-maker: Create a UTC timestamped text file
date-file-maker() {
    local fname
    fname="$(date -u '+%m-%d-%y-%H:%M:%S').txt"
    touch "$fname"
    _gg_ok "Created $fname"
}

# swap: Swap the names of two files
# Usage: swap file1 file2
swap() {
    if [ -z "$2" ]; then
        _gg_err "Usage: swap <file1> <file2>"
        return 1
    fi
    if [ ! -e "$1" ]; then _gg_err "File not found: $1"; return 1; fi
    if [ ! -e "$2" ]; then _gg_err "File not found: $2"; return 1; fi
    local tmp_name
    tmp_name=$(TMPDIR=$(dirname -- "$1") mktemp)
    mv -f -- "$1" "$tmp_name"
    mv -f -- "$2" "$1"
    mv -f -- "$tmp_name" "$2"
    _gg_ok "Swapped $1 <-> $2"
}

# mkcd: mkdir and cd into it
mkcd() {
    if [ -z "$1" ]; then
        _gg_err "Usage: mkcd <dirname>"
        return 1
    fi
    mkdir -p "$1" && cd "$1" || return 1
    _gg_ok "Created and entered $1"
}

# extract: universal archive extractor
extract() {
    if [ -z "$1" ]; then
        _gg_err "Usage: extract <archive>"
        return 1
    fi
    if [ ! -f "$1" ]; then
        _gg_err "'$1' is not a valid file."
        return 1
    fi
    case "$1" in
        *.tar.bz2) tar xjf "$1"   ;;
        *.tar.gz)  tar xzf "$1"   ;;
        *.tar.xz)  tar xJf "$1"   ;;
        *.bz2)     bunzip2 "$1"   ;;
        *.gz)      gunzip "$1"    ;;
        *.tar)     tar xf "$1"    ;;
        *.tbz2)    tar xjf "$1"   ;;
        *.tgz)     tar xzf "$1"   ;;
        *.zip)     unzip "$1"     ;;
        *.7z)      7z x "$1"      ;;
        *.rar)     unrar x "$1"   ;;
        *) _gg_err "Cannot extract '$1': unknown format"; return 1 ;;
    esac
    _gg_ok "Extracted $1"
}

# tre: tree with sensible defaults (ignore .git, node_modules)
tre() {
    if command -v tree &>/dev/null; then
        tree -I '.git|node_modules|__pycache__|.venv|venv' -a --dirsfirst "${@:-.}"
    else
        _gg_warn "'tree' not installed. Falling back to find."
        find "${@:-.}" -not -path '*/.git/*' -not -path '*/node_modules/*' | head -100
    fi
}

# ports: show what's listening on which ports
ports() {
    if command -v lsof &>/dev/null; then
        lsof -iTCP -sTCP:LISTEN -P -n
    elif command -v ss &>/dev/null; then
        ss -tlnp
    else
        _gg_err "Neither lsof nor ss available."
        return 1
    fi
}

# sizeof: human-readable size of a file or directory
sizeof() {
    if [ -z "$1" ]; then
        _gg_err "Usage: sizeof <path>"
        return 1
    fi
    du -sh "$1" 2>/dev/null | cut -f1
}

# blk: Run Python Black formatter on a file
# Usage: blk filename.py
blk() {
    if [ -z "$1" ]; then
        _gg_err "Usage: blk <filename.py>"
        return 1
    fi
    python3 -m black "$1"
}

# serve: quick HTTP server in current directory
serve() {
    local port="${1:-8000}"
    _gg_info "Serving on http://localhost:$port ..."
    python3 -m http.server "$port"
}

# jql: pipe JSON through jq with color, into less
jql() {
    if ! command -v jq &>/dev/null; then
        _gg_err "jq is not installed."
        return 1
    fi
    jq -C '.' "$@" | less -R
}

# Remove .DS_Store files recursively
rmdstore() {
    find . -name ".DS_Store" -type f -delete
    echo "Removed all .DS_Store files"
}

# Remove node_modules recursively
rmnodemodules() {
    echo "Finding node_modules directories..."
    find . -name "node_modules" -type d -prune
    read -p "Remove all node_modules directories? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        find . -name "node_modules" -type d -prune -exec rm -rf {} \;
        echo "Removed all node_modules directories"
    else
        echo "Cancelled"
    fi
}

# Count files by extension
countext() {
    find . -type f | sed 's/.*\.//' | sort | uniq -c | sort -rn
}

# Find large files in directory
findlarge() {
    find . -type f -size +${1:-10M} -exec ls -lh {} \; | awk '{ print $9 ": " $5 }'
}

