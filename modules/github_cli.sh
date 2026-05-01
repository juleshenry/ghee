#!/bin/bash
# ============================================================================
# Module: Github Cli
# Description: Ghee shortcuts and utilities for Github Cli.
# ============================================================================

# GitHub CLI (gh) Shortcuts

_GG_REGISTRY["ghpr"]="gh pr create ||| Create a GitHub pull request"
_GG_REGISTRY["ghprs"]="gh pr status ||| Show status of PR for current branch"
_GG_REGISTRY["ghprl"]="gh pr list ||| List open pull requests"
_GG_REGISTRY["ghprd"]="gh pr diff ||| Show diff of current PR"
_GG_REGISTRY["ghprm"]="gh pr merge ||| Merge current pull request"
_GG_REGISTRY["ghprco"]="gh pr checkout NUMBER ||| Checkout a pull request by number"
_GG_REGISTRY["ghil"]="gh issue list ||| List open GitHub issues"
_GG_REGISTRY["ghic"]="gh issue create ||| Create a new GitHub issue"
_GG_REGISTRY["ghiv"]="gh issue view NUMBER ||| View a specific issue"
_GG_REGISTRY["ghrl"]="gh release list ||| List GitHub releases"
_GG_REGISTRY["ghrc"]="gh release create ||| Create a new GitHub release"
_GG_REGISTRY["ghrepo"]="gh repo view --web ||| Open current repo in browser"
_GG_REGISTRY["ghrun"]="gh run list ||| List recent GitHub Actions workflow runs"
_GG_REGISTRY["ghrw"]="gh run watch ||| Watch GitHub Actions run live"
_GG_REGISTRY["ghssh"]="gh auth refresh -h github.com -s admin:public_key ||| Add SSH key to GitHub"
_GG_REGISTRY["ghclone"]="gh repo clone OWNER/REPO ||| Clone repo using gh (auto SSH)"
_GG_REGISTRY["ghfork"]="gh repo fork --clone ||| Fork and clone a GitHub repo"

alias ghpr='gh pr create'
alias ghprs='gh pr status'
alias ghprl='gh pr list'
alias ghprd='gh pr diff'
alias ghprm='gh pr merge'

ghprco() {
    if [ -z "$1" ]; then echo "Usage: ghprco <PR number>"; return 1; fi
    gh pr checkout "$1"
}

alias ghil='gh issue list'
alias ghic='gh issue create'

ghiv() {
    if [ -z "$1" ]; then echo "Usage: ghiv <issue number>"; return 1; fi
    gh issue view "$1"
}

alias ghrl='gh release list'
alias ghrc='gh release create'
alias ghrepo='gh repo view --web'
alias ghrun='gh run list'
alias ghrw='gh run watch'
alias ghclone='gh repo clone'
alias ghfork='gh repo fork --clone'
