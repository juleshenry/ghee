#!/bin/bash
# ============================================================================
# Module: Misc Cli Tools
# Description: Ghee shortcuts and utilities for Misc Cli Tools.
# ============================================================================

# Misc CLI Tools

_GG_REGISTRY["duh"]="du -sh * | sort -rh ||| Disk usage summary (sorted)"]
_GG_REGISTRY["dfh"]="df -h ||| Disk free (human-readable)"]
_GG_REGISTRY["fmem"]="free -h ||| Free memory"]
_GG_REGISTRY["cpuinfo"]="lscpu ||| CPU info"]
_GG_REGISTRY["w2"]="watch -n 2 CMD ||| Watch a command every 2 seconds"]
_GG_REGISTRY["lsofp"]="lsof -c PROCESS ||| List open files by process"]
_GG_REGISTRY["killname"]="pkill -f NAME ||| Kill process by name"]
_GG_REGISTRY["hist"]="history | tail -50 ||| Last 50 history entries"]
_GG_REGISTRY["cl"]="clear ||| Clear terminal"]
_GG_REGISTRY["reload"]="exec \$SHELL -l ||| Reload shell config"]
_GG_REGISTRY["erc"]="\${EDITOR:-vi} ~/.<shell>rc ||| Edit shell RC file"]
_GG_REGISTRY["path"]="echo \$PATH | tr : newline ||| Show PATH (one per line)"]
_GG_REGISTRY["cx"]="chmod +x FILE ||| Make file executable"]
_GG_REGISTRY["isodate"]="date -u +%Y-%m-%dT%H:%M:%SZ ||| Print ISO 8601 timestamp"]
_GG_REGISTRY["sha256"]="shasum -a 256 FILE ||| SHA256 hash of file"]
_GG_REGISTRY["md5sum"]="md5 FILE ||| MD5 hash of file"]

# 320. Disk usage summary
alias duh='du -sh * | sort -rh'

# 321. Disk free human-readable
alias dfh='df -h'

# 322. Free memory (Linux)
alias fmem='free -h 2>/dev/null || vm_stat'

# 323. CPU info
alias cpuinfo='lscpu 2>/dev/null || sysctl -a | grep machdep.cpu'

# 324. Watch a command (every 2s)
alias w2='watch -n 2'

# 325. List open files by process
alias lsofp='lsof -c'

# 326. Kill process by name
alias killname='pkill -f'

# 328. History shortcut
alias hist='history | tail -50'

# 329. Clear terminal
alias cl='clear'

# 330. Reload shell config
alias reload='exec $SHELL -l'

# 331. Edit shell config
alias erc='${EDITOR:-vi} ~/.${SHELL##*/}rc'

# 332. Show PATH entries (one per line)
alias path='echo $PATH | tr ":" "\n"'

# 333. Make executable
alias cx='chmod +x'

# 334. Timestamp (epoch)
alias epoch='date +%s'

# 335. Timestamp ISO
alias isodate='date -u +"%Y-%m-%dT%H:%M:%SZ"'

# 336. UUID generator
alias uuid='python3 -c "import uuid; print(uuid.uuid4())"'

# 337. Base64 encode
alias b64e='base64'

# 338. Base64 decode
alias b64d='base64 --decode'

# 339. SHA256 hash of file
alias sha256='shasum -a 256'

# 340. MD5 hash of file
alias md5sum='md5 2>/dev/null || md5sum'

