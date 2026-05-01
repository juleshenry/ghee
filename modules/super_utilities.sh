#!/bin/bash
# ============================================================================
# Module: Super Utilities
# Description: Ghee shortcuts and utilities for Super Utilities.
# ============================================================================

# Super Utilities

_GG_REGISTRY["cheat"]="curl cheat.sh/CMD ||| Get cheat sheet for any CLI command"
_GG_REGISTRY["weather"]="curl wttr.in/LOCATION ||| Get the weather forecast in terminal"
_GG_REGISTRY["qrgen"]="curl qrencode.com/STRING ||| Generate a QR code in the terminal"
_GG_REGISTRY["uuid"]="uuidgen | tr '[:upper:]' '[:lower:]' ||| Generate a random UUIDv4"
_GG_REGISTRY["epoch"]="date +%s ||| Get current Unix Epoch timestamp"
_GG_REGISTRY["stopwatch"]="time read ||| Start a simple stopwatch (press Enter to stop)"
_GG_REGISTRY["timer"]="sleep N && echo 'Time is up!' ||| Simple countdown timer"
_GG_REGISTRY["matrix"]="Pure Bash Matrix Effect ||| Run the Matrix digital rain in your terminal"

cheat() {
    if [ -z "$1" ]; then echo "Usage: cheat <command> (e.g. cheat tar)"; return 1; fi
    curl "cheat.sh/$1"
}

weather() {
    curl "wttr.in/${1}"
}

qrgen() {
    if [ -z "$1" ]; then echo "Usage: qrgen <string_or_url>"; return 1; fi
    curl "qrencode.com/$1"
}

alias uuid='uuidgen | tr "[:upper:]" "[:lower:]"'
alias epoch='date +%s'
alias stopwatch='echo "Press ENTER to stop..."; time read'

timer() {
    if [ -z "$1" ]; then echo "Usage: timer <seconds>"; return 1; fi
    echo "Timer set for $1 seconds..."
    sleep "$1"
    echo -e "\007Time is up!"
}

alias matrix='LC_ALL=C tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock 2>/dev/null | GREP_COLOR="1;32" grep --color "[^ ]"'
