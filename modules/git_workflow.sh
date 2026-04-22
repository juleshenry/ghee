#!/bin/bash
# ============================================================================
# Module: Git Workflow
# Description: Ghee shortcuts and utilities for Git Workflow.
# ============================================================================

# Git Workflow

_GG_REGISTRY["gg"]="git add . && git commit -m MSG && git push ||| Add all, commit, push in one shot"]
_GG_REGISTRY["gclo"]="git clone https://github.com/USER/REPO ||| Clone a GitHub repo"]
_GG_REGISTRY["jclo"]="git clone https://github.com/juleshenry/REPO ||| Clone a juleshenry repo"]
_GG_REGISTRY["presto"]="git checkout --orphan && force-push ||| DESTRUCTIVE: wipe all git history"]
_GG_REGISTRY["gwip"]="git add . && git commit -m 'wip: TIME' ||| Quick work-in-progress commit (no push)"]
_GG_REGISTRY["gunwip"]="git reset --soft HEAD~1 ||| Undo last WIP commit, keep changes staged"]
_GG_REGISTRY["gpristine"]="git reset --hard origin/BRANCH && git clean -fd ||| Hard-reset to match remote exactly"]
_GG_REGISTRY["gtag"]="git tag -a TAG -m MSG && git push origin TAG ||| Create and push a git tag"]
_GG_REGISTRY["ghprc"]="gh pr create --title TITLE --fill ||| Create a GitHub PR via gh CLI"]
_GG_REGISTRY["gdiff-fancy"]="git diff --stat + git diff --shortstat ||| Pretty diff summary with stats"]
_GG_REGISTRY["gacp"]="git add . && git commit -m MSG && git push ||| Add, commit, push (same as gg)"]
_GG_REGISTRY["ginit"]="git init && git add . && git commit -m 'Initial commit' ||| Init repo with first commit"]
_GG_REGISTRY["ghcl"]="git clone https://github.com/USER/REPO ||| Clone from GitHub"]
_GG_REGISTRY["gbc"]="git checkout -b BRANCH ||| Create and switch to new branch"]
_GG_REGISTRY["gbdall"]="git branch -d B && git push origin --delete B ||| Delete branch locally + remotely"]
_GG_REGISTRY["gundo"]="git reset --soft HEAD~1 ||| Undo last commit, keep changes staged"]
_GG_REGISTRY["gbs"]="git for-each-ref --sort=-committerdate ||| Show branches sorted by last modified"]
_GG_REGISTRY["gquick"]="git add . && git commit -m 'Quick update: TIME' && git push ||| Commit+push with auto-timestamp"]
_GG_REGISTRY["gchanged"]="git diff --name-only HEAD~N..HEAD ||| Show changed files in last N commits"]
_GG_REGISTRY["gsearchtext"]="git log -S TEXT ||| Search for text across git history"]
_GG_REGISTRY["gnew"]="git fetch origin && git checkout -b B origin/main ||| Create branch from origin/main"]
_GG_REGISTRY["gupdateall"]="git fetch --all && git pull ||| Fetch all remotes and pull"]
_GG_REGISTRY["greposize"]="git count-objects -vH ||| Show repo object storage size"]
_GG_REGISTRY["gfilesize"]="git ls-tree -r -t -l --full-name HEAD | sort ||| List files by size in repo"]
_GG_REGISTRY["glarge"]="git rev-list --objects --all | ... ||| Find N largest blobs in history"]
_GG_REGISTRY["gsyncfork"]="git fetch upstream && merge upstream/main ||| Sync fork with upstream/main"]
_GG_REGISTRY["gsquash"]="git reset --soft HEAD~N && git commit -m MSG ||| Squash last N commits"]
_GG_REGISTRY["gstats"]="git shortlog -sn --all --no-merges ||| Commit count by author"]
_GG_REGISTRY["garchive"]="git tag archive/B && delete branch ||| Archive a branch as a tag"]
_GG_REGISTRY["galias"]="alias | grep '^g' ||| List all g* aliases"]
_GG_REGISTRY["ginfo"]="repo name, branch, remote, last commit ||| Show repo info summary"]
_GG_REGISTRY["gbackup"]="tar -czf backup.tar.gz . ||| Tar.gz backup of current repo"]

# gg: git add, commit, and push in one command
# Usage: gg "commit message"
gg() {
    if [ -z "$1" ]; then
        _gg_err "Usage: gg \"commit message\""
        return 1
    fi
    _gg_info "Staging all changes..."
    git add . || { _gg_err "git add failed"; return 1; }
    _gg_info "Committing: $1"
    git commit -m "$1" || { _gg_err "git commit failed"; return 1; }
    _gg_info "Pushing to remote..."
    git push || { _gg_err "git push failed"; return 1; }
    _gg_ok "Done -- add, commit, push complete."
}

# gclo: git clone shortcut
# Usage: gclo username/repo
gclo() {
    if [ -z "$1" ]; then
        _gg_err "Usage: gclo username/repo"
        return 1
    fi
    _gg_info "Cloning github.com/$1 ..."
    git clone "https://github.com/$1"
}

# jclo: git clone for juleshenry repositories
# Usage: jclo reponame
jclo() {
    if [ -z "$1" ]; then
        _gg_err "Usage: jclo reponame"
        return 1
    fi
    local j=juleshenry
    _gg_info "Cloning github.com/$j/$1 ..."
    git clone "https://github.com/$j/$1"
}

# presto: Delete all git history - use with extreme caution!
presto() {
    _gg_warn "This will ${_gg_bold}DESTROY ALL GIT HISTORY${_gg_reset} for this repo."
    read -p "Type 'yes' to confirm: " confirm
    if [ "$confirm" != "yes" ]; then
        _gg_info "Aborted."
        return 1
    fi
    git checkout --orphan annie
    git add -A
    git commit -am 'cm'
    git branch -D main
    git branch -m main
    git push -f origin main
    _gg_ok "History wiped. Fresh start on main."
}

# gwip: quick work-in-progress commit (no push)
gwip() {
    git add .
    git commit -m "wip: $(date '+%H:%M:%S')"
    _gg_ok "WIP commit saved."
}

# gunwip: undo last wip commit, keep changes staged
gunwip() {
    local last_msg
    last_msg=$(git log -1 --pretty=%s 2>/dev/null)
    if [[ "$last_msg" == wip:* ]]; then
        git reset --soft HEAD~1
        _gg_ok "Unwound WIP commit. Changes are staged."
    else
        _gg_warn "Last commit doesn't look like a WIP: $last_msg"
        return 1
    fi
}

# gpristine: reset repo to match remote exactly
gpristine() {
    _gg_warn "Discarding ALL local changes to match remote."
    read -p "Continue? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git reset --hard origin/"$(git branch --show-current)"
        git clean -fd
        _gg_ok "Repo is pristine."
    else
        _gg_info "Aborted."
    fi
}

# gtag: create and push a tag in one step
# Usage: gtag v1.0.0 "Release message"
gtag() {
    if [ -z "$1" ]; then
        _gg_err "Usage: gtag <tag> [message]"
        return 1
    fi
    local msg="${2:-$1}"
    git tag -a "$1" -m "$msg" && git push origin "$1"
    _gg_ok "Tag $1 created and pushed."
}

# gpr: create a pull request via gh CLI
# Usage: gpr "PR title"
gpr() {
    if ! command -v gh &>/dev/null; then
        _gg_err "GitHub CLI (gh) is not installed."
        return 1
    fi
    if [ -z "$1" ]; then
        _gg_err "Usage: gpr \"PR title\""
        return 1
    fi
    git push -u origin "$(git branch --show-current)" 2>/dev/null
    gh pr create --title "$1" --fill
    _gg_ok "PR created."
}

# gdiff-fancy: show a pretty diff summary
gdiff-fancy() {
    echo -e "${_gg_bold}--- Changes Summary ---${_gg_reset}"
    echo -e "${_gg_green}$(git diff --stat)${_gg_reset}"
    echo ""
    echo -e "${_gg_dim}$(git diff --shortstat)${_gg_reset}"
}

# Quick add, commit, push
gacp() {
    if [ -z "$1" ]; then
        echo "Usage: gacp <commit_message>"
        return 1
    fi
    git add . && git commit -m "$1" && git push
}

# Initialize git repo with initial commit
ginit() {
    git init
    git add .
    git commit -m "Initial commit"
}

# Quick clone from GitHub
ghcl() {
    if [ -z "$1" ]; then
        echo "Usage: ghcl <username/repo>"
        return 1
    fi
    git clone "https://github.com/$1"
}

# Create branch and switch to it
gbc() {
    if [ -z "$1" ]; then
        echo "Usage: gbc <branch_name>"
        return 1
    fi
    git checkout -b "$1"
}

# Delete branch both locally and remotely
gbdall() {
    if [ -z "$1" ]; then
        echo "Usage: gbdall <branch_name>"
        return 1
    fi
    git branch -d "$1" && git push origin --delete "$1"
}

# Undo last commit but keep changes
gundo() {
    git reset --soft HEAD~1
}

# Show branches sorted by last modified
gbs() {
    git for-each-ref --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'
}

# Quick commit and push all changes with timestamp
gquick() {
    git add .
    git commit -m "Quick update: $(date '+%Y-%m-%d %H:%M:%S')"
    git push
}

# Show changed files in last N commits
gchanged() {
    git diff --name-only HEAD~${1:-5}..HEAD
}

# Search for text in git history
gsearchtext() {
    git log -S "$1" --pretty=format:"%h %ad %s" --date=short
}

# Create new branch from origin/main
gnew() {
    if [ -z "$1" ]; then
        echo "Usage: gnew <branch_name>"
        return 1
    fi
    git fetch origin && git checkout -b "$1" origin/main
}

# Update current branch from all remotes
gupdateall() {
    git fetch --all
    git pull
}

# Show size of repository
greposize() {
    git count-objects -vH
}

# List files by size
gfilesize() {
    git ls-tree -r -t -l --full-name HEAD | sort -n -k 4
}

# Find large files in history
glarge() {
    local count=${1:-10}
    git rev-list --objects --all | \
        git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
        awk '/^blob/ {print substr($0,6)}' | \
        sort --numeric-sort --key=2 | \
        tail -${count}
}

# Sync fork with upstream
gsyncfork() {
    git fetch upstream && \
    git checkout main && \
    git merge upstream/main && \
    git push origin main
}

# Squash last N commits
gsquash() {
    if [ -z "$2" ]; then
        echo "Usage: gsquash <number_of_commits> <commit_message>"
        return 1
    fi
    git reset --soft HEAD~${1:-2}
    git commit -m "$2"
}

# Show commit count by author
gstats() {
    git shortlog -sn --all --no-merges
}

# Archive branch
garchive() {
    git tag archive/"$1" "$1"
    git branch -d "$1"
    git push origin --delete "$1"
    git push origin archive/"$1"
}

# List aliases
galias() {
    alias | grep '^g'
}

# Show git info
ginfo() {
    echo "Repository: $(basename $(git rev-parse --show-toplevel))"
    echo "Branch: $(git branch --show-current)"
    echo "Remote: $(git remote get-url origin 2>/dev/null || echo 'No remote')"
    echo "Last commit: $(git log -1 --pretty=format:'%h - %s (%ar)')"
    echo "Files changed: $(git status -s | wc -l)"
}

# Backup git repository
gbackup() {
    local backup_name="git-backup-$(date +%Y%m%d-%H%M%S).tar.gz"
    tar -czf "../$backup_name" .
    echo "Backup created: ../$backup_name"
}

