#!/bin/bash
# ============================================================================
# Module: SSH & SCP
# Description: Ghee shortcuts and utilities for SSH and SCP.
# ============================================================================

# SSH

_GG_REGISTRY["sshtun"]="ssh -L LOCAL_PORT:localhost:REMOTE_PORT USER@HOST ||| SSH local port forwarding tunnel"]
_GG_REGISTRY["sshrtun"]="ssh -R REMOTE_PORT:localhost:LOCAL_PORT USER@HOST ||| SSH reverse tunnel"]
_GG_REGISTRY["sshcopy"]="ssh-copy-id USER@HOST ||| Copy SSH key to remote host"]
_GG_REGISTRY["sshv"]="ssh -vvv USER@HOST ||| SSH with verbose output"]
_GG_REGISTRY["sshedit"]="\${EDITOR:-vim} ~/.ssh/config ||| Edit SSH config"]
_GG_REGISTRY["sshkeygen"]="ssh-keygen -t ed25519 -C EMAIL ||| Generate ed25519 SSH key"]
_GG_REGISTRY["sshadd"]="ssh-add ~/.ssh/id_ed25519 ||| Add SSH key to agent"]
_GG_REGISTRY["sshls"]="ssh-add -l ||| List keys loaded in SSH agent"]
_GG_REGISTRY["sshjump"]="ssh -J JUMP_HOST USER@DEST_HOST ||| SSH via jump host / proxy"]
_GG_REGISTRY["sshtest"]="ssh -o ConnectTimeout=5 -q USER@HOST exit ||| Test SSH connection"]

# SCP

_GG_REGISTRY["scpto"]="scp FILE USER@HOST:REMOTE_PATH ||| SCP file to remote"]
_GG_REGISTRY["scpfrom"]="scp USER@HOST:REMOTE_FILE LOCAL_PATH ||| SCP file from remote"]
_GG_REGISTRY["scptor"]="scp -r DIR USER@HOST:REMOTE_PATH ||| SCP directory to remote (recursive)"]
_GG_REGISTRY["scpfromr"]="scp -r USER@HOST:REMOTE_DIR LOCAL_PATH ||| SCP directory from remote (recursive)"]

# Aliases

alias sshtun='ssh -L'
alias sshrtun='ssh -R'
alias sshcopy='ssh-copy-id'
alias sshv='ssh -vvv'
alias sshedit='${EDITOR:-vim} ~/.ssh/config'
alias sshkeygen='ssh-keygen -t ed25519 -C'
alias sshadd='ssh-add ~/.ssh/id_ed25519'
alias sshls='ssh-add -l'
alias sshjump='ssh -J'
alias sshtest='ssh -o ConnectTimeout=5 -q'
alias scpto='scp'
alias scpfrom='scp'
alias scptor='scp -r'
alias scpfromr='scp -r'
