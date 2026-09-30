#!/bin/bash
# ============================================================================
# Module: Homebrew
# Description: Ghee shortcuts and utilities for Homebrew (macOS package manager).
# ============================================================================

# Homebrew

_GG_REGISTRY["brewi"]="brew install PACKAGE ||| Install a Homebrew package"
_GG_REGISTRY["brewic"]="brew install --cask APP ||| Install a Homebrew cask (GUI app)"
_GG_REGISTRY["brewu"]="brew upgrade ||| Upgrade all Homebrew packages"
_GG_REGISTRY["brewup"]="brew upgrade PACKAGE ||| Upgrade a specific package"
_GG_REGISTRY["brewun"]="brew uninstall PACKAGE ||| Uninstall a Homebrew package"
_GG_REGISTRY["brewls"]="brew list ||| List installed Homebrew packages"
_GG_REGISTRY["brewlsc"]="brew list --cask ||| List installed casks"
_GG_REGISTRY["brews"]="brew search TERM ||| Search Homebrew packages"
_GG_REGISTRY["brewinfo"]="brew info PACKAGE ||| Show info about a package"
_GG_REGISTRY["brewout"]="brew outdated ||| List outdated packages"
_GG_REGISTRY["brewdr"]="brew doctor ||| Check Homebrew for issues"
_GG_REGISTRY["brewcl"]="brew cleanup ||| Remove old versions and cache"
_GG_REGISTRY["brewpin"]="brew pin PACKAGE ||| Pin a package to prevent upgrades"
_GG_REGISTRY["brewupin"]="brew unpin PACKAGE ||| Unpin a package"
_GG_REGISTRY["brewsv"]="brew services list ||| List all Homebrew services"
_GG_REGISTRY["brewstart"]="brew services start SERVICE ||| Start a Homebrew service"
_GG_REGISTRY["brewstop"]="brew services stop SERVICE ||| Stop a Homebrew service"
_GG_REGISTRY["brewre"]="brew services restart SERVICE ||| Restart a Homebrew service"
_GG_REGISTRY["brewdeps"]="brew deps --tree PACKAGE ||| Show dependency tree for a package"
_GG_REGISTRY["brewsize"]="brew info PACKAGE | grep -i 'installed' ||| Show installed size of a package"

# ── brewup-all: upgrade everything and clean up ──
brewup-all() {
    echo "Updating Homebrew..."
    brew update && brew upgrade && brew cleanup
    echo "Done."
}
_GG_REGISTRY["brewup-all"]="brew update && upgrade && cleanup ||| Update, upgrade, and clean up everything"

alias brewi='brew install'
alias brewic='brew install --cask'
alias brewu='brew upgrade'
alias brewup='brew upgrade'
alias brewun='brew uninstall'
alias brewls='brew list'
alias brewlsc='brew list --cask'
alias brews='brew search'
alias brewinfo='brew info'
alias brewout='brew outdated'
alias brewdr='brew doctor'
alias brewcl='brew cleanup'
alias brewpin='brew pin'
alias brewupin='brew unpin'
alias brewsv='brew services list'
alias brewstart='brew services start'
alias brewstop='brew services stop'
alias brewre='brew services restart'
alias brewdeps='brew deps --tree'

brewsize() {
    if [ -z "$1" ]; then echo "Usage: brewsize <package>"; return 1; fi
    brew info "$1" | grep -i 'installed'
}
