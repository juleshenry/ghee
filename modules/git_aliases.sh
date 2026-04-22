#!/bin/bash
# ============================================================================
# Module: Git Aliases
# Description: Ghee shortcuts and utilities for Git Aliases.
# ============================================================================

# Git Aliases (mega_script)

_GG_REGISTRY["gs"]="git status ||| Show working tree status"]
_GG_REGISTRY["gss"]="git status -s ||| Short-format status"]
_GG_REGISTRY["ga"]="git add . ||| Stage all changes"]
_GG_REGISTRY["gaf"]="git add FILE ||| Stage a specific file"]
_GG_REGISTRY["gc"]="git commit -m MSG ||| Commit with message"]
_GG_REGISTRY["gca"]="git commit -a -m MSG ||| Commit all tracked files"]
_GG_REGISTRY["gcam"]="git commit --amend -m MSG ||| Amend last commit message"]
_GG_REGISTRY["gcan"]="git commit --amend --no-edit ||| Amend last commit, keep message"]
_GG_REGISTRY["gp"]="git push ||| Push to origin"]
_GG_REGISTRY["gpf"]="git push --force ||| Force push"]
_GG_REGISTRY["gpfl"]="git push --force-with-lease ||| Force push (safer)"]
_GG_REGISTRY["gpu"]="git push -u origin BRANCH ||| Push and set upstream"]
_GG_REGISTRY["gl"]="git pull ||| Pull from origin"]
_GG_REGISTRY["glr"]="git pull --rebase ||| Pull with rebase"]
_GG_REGISTRY["glp"]="git pull --prune ||| Pull and prune dead refs"]
_GG_REGISTRY["gb"]="git branch ||| List local branches"]
_GG_REGISTRY["gba"]="git branch -a ||| List all branches (local+remote)"]
_GG_REGISTRY["gbd"]="git branch -d BRANCH ||| Delete a branch"]
_GG_REGISTRY["gbdf"]="git branch -D BRANCH ||| Force delete a branch"]
_GG_REGISTRY["gco"]="git checkout BRANCH ||| Checkout a branch"]
_GG_REGISTRY["gcob"]="git checkout -b BRANCH ||| Create + checkout new branch"]
_GG_REGISTRY["gcop"]="git checkout - ||| Checkout previous branch"]
_GG_REGISTRY["gcom"]="git checkout main || git checkout master ||| Checkout main/master"]
_GG_REGISTRY["gsw"]="git switch BRANCH ||| Switch to branch (modern)"]
_GG_REGISTRY["gswc"]="git switch -c BRANCH ||| Create + switch to new branch"]
_GG_REGISTRY["gm"]="git merge BRANCH ||| Merge a branch"]
_GG_REGISTRY["gmnf"]="git merge --no-ff BRANCH ||| Merge with no fast-forward"]
_GG_REGISTRY["gma"]="git merge --abort ||| Abort a merge"]
_GG_REGISTRY["gbm"]="git branch --merged ||| Show merged branches"]
_GG_REGISTRY["glog"]="git log --oneline --decorate --graph ||| Pretty commit graph"]
_GG_REGISTRY["gloga"]="git log --oneline --decorate --graph --all ||| Pretty graph, all branches"]
_GG_REGISTRY["glogd"]="git log --pretty=format:'%h %ad %s' --date=short ||| Log with dates"]
_GG_REGISTRY["glogs"]="git log --stat ||| Log with file stats"]
_GG_REGISTRY["glogp"]="git log -p ||| Log with patches"]
_GG_REGISTRY["glast"]="git log -1 HEAD ||| Show last commit"]
_GG_REGISTRY["gblame"]="git blame FILE ||| Show who changed each line"]
_GG_REGISTRY["gshow"]="git show ||| Show last commit details"]
_GG_REGISTRY["gauthor"]="git log --author NAME ||| Filter log by author"]
_GG_REGISTRY["gsearch"]="git log --all --grep TERM ||| Search commit messages"]
_GG_REGISTRY["gbv"]="git branch -v ||| Branches with last commit"]
_GG_REGISTRY["gbvv"]="git branch -vv ||| Branches with tracking info"]
_GG_REGISTRY["grl"]="git reflog ||| Show reflog"]
_GG_REGISTRY["gd"]="git diff ||| Show unstaged diff"]
_GG_REGISTRY["gds"]="git diff --staged ||| Show staged diff"]
_GG_REGISTRY["gdst"]="git diff --stat ||| Diff with stats"]
_GG_REGISTRY["gdw"]="git diff --word-diff ||| Word-level diff"]
_GG_REGISTRY["gdc"]="git diff --color-words ||| Color word diff"]
_GG_REGISTRY["gdfiles"]="git diff --name-only ||| List changed filenames"]
_GG_REGISTRY["gdstat"]="git diff --name-status ||| Changed files with status"]
_GG_REGISTRY["gdlc"]="git diff HEAD^ HEAD ||| Diff of last commit"]
_GG_REGISTRY["glst"]="git ls-files ||| List tracked files"]
_GG_REGISTRY["glsu"]="git ls-files --others ||| List untracked files"]
_GG_REGISTRY["gcontrib"]="git shortlog -sn ||| Show contributors"]
_GG_REGISTRY["gfh"]="git log --follow -p -- FILE ||| Show full file history"]
_GG_REGISTRY["gst"]="git stash ||| Stash changes"]
_GG_REGISTRY["gstm"]="git stash push -m MSG ||| Stash with message"]
_GG_REGISTRY["gstu"]="git stash -u ||| Stash including untracked"]
_GG_REGISTRY["gsta"]="git stash -a ||| Stash all (including ignored)"]
_GG_REGISTRY["gstl"]="git stash list ||| List stashes"]
_GG_REGISTRY["gsts"]="git stash show -p ||| Show stash content"]
_GG_REGISTRY["gstap"]="git stash apply ||| Apply last stash"]
_GG_REGISTRY["gstpo"]="git stash pop ||| Pop last stash"]
_GG_REGISTRY["gstd"]="git stash drop ||| Drop a stash"]
_GG_REGISTRY["gstc"]="git stash clear ||| Clear all stashes"]
_GG_REGISTRY["gr"]="git remote ||| Show remotes"]
_GG_REGISTRY["grv"]="git remote -v ||| Show remotes with URLs"]
_GG_REGISTRY["gra"]="git remote add NAME URL ||| Add a remote"]
_GG_REGISTRY["grr"]="git remote remove NAME ||| Remove a remote"]
_GG_REGISTRY["gf"]="git fetch ||| Fetch from origin"]
_GG_REGISTRY["gfa"]="git fetch --all ||| Fetch all remotes"]
_GG_REGISTRY["gfp"]="git fetch --prune ||| Fetch with prune"]
_GG_REGISTRY["gcl"]="git clone URL ||| Clone a repository"]
_GG_REGISTRY["gcld"]="git clone --depth 1 URL ||| Shallow clone"]
_GG_REGISTRY["grss"]="git reset --soft HEAD~1 ||| Soft reset last commit"]
_GG_REGISTRY["grsm"]="git reset HEAD~1 ||| Mixed reset last commit"]
_GG_REGISTRY["grsh"]="git reset --hard HEAD~1 ||| Hard reset last commit"]
_GG_REGISTRY["grso"]="git reset --hard origin/BRANCH ||| Reset to origin"]
_GG_REGISTRY["gus"]="git reset HEAD ||| Unstage all files"]
_GG_REGISTRY["gusf"]="git reset HEAD -- FILE ||| Unstage a specific file"]
_GG_REGISTRY["gcn"]="git clean -n ||| Clean dry run"]
_GG_REGISTRY["gcf"]="git clean -f ||| Clean untracked files"]
_GG_REGISTRY["gcfd"]="git clean -fd ||| Clean untracked files + dirs"]
_GG_REGISTRY["gdis"]="git checkout -- FILE ||| Discard changes in file"]
_GG_REGISTRY["gcpy"]="git cherry-pick HASH ||| Cherry-pick a commit"]
_GG_REGISTRY["gcpc"]="git cherry-pick --continue ||| Continue cherry-pick"]
_GG_REGISTRY["gcpa"]="git cherry-pick --abort ||| Abort cherry-pick"]
_GG_REGISTRY["grbi"]="git rebase -i HASH ||| Interactive rebase"]
_GG_REGISTRY["grbc"]="git rebase --continue ||| Continue rebase"]
_GG_REGISTRY["grba"]="git rebase --abort ||| Abort rebase"]
_GG_REGISTRY["grbs"]="git rebase --skip ||| Skip rebase step"]
_GG_REGISTRY["gt"]="git tag ||| Show tags"]
_GG_REGISTRY["gta"]="git tag -a TAG ||| Create annotated tag"]
_GG_REGISTRY["gpht"]="git push --tags ||| Push all tags"]

# 2. Quick status
alias gs='git status'

# 3. Quick status with short format
alias gss='git status -s'

# 4. Add all changes
alias ga='git add .'

# 5. Add specific file
alias gaf='git add'

# 6. Commit with message
alias gc='git commit -m'

# 7. Commit all tracked files
alias gca='git commit -a -m'

# 8. Amend last commit
alias gcam='git commit --amend -m'

# 9. Amend without changing message
alias gcan='git commit --amend --no-edit'

# 10. Push to origin
alias gp='git push'

# 11. Push with force
alias gpf='git push --force'

# 12. Push with force (safer)
alias gpfl='git push --force-with-lease'

# 13. Push and set upstream
alias gpu='git push -u origin'

# 14. Pull from origin
alias gl='git pull'

# 15. Pull with rebase
alias glr='git pull --rebase'

# 16. Pull and prune
alias glp='git pull --prune'

# 17. List branches
alias gb='git branch'

# 18. List all branches (including remote)
alias gba='git branch -a'

# 20. Delete branch
alias gbd='git branch -d'

# 21. Force delete branch
alias gbdf='git branch -D'

# 22. Checkout branch
alias gco='git checkout'

# 23. Checkout new branch
alias gcob='git checkout -b'

# 24. Checkout previous branch
alias gcop='git checkout -'

# 25. Checkout master/main
alias gcom='git checkout main || git checkout master'

# 26. Switch to branch (newer syntax)
alias gsw='git switch'

# 27. Create and switch to new branch
alias gswc='git switch -c'

# 28. Merge branch
alias gm='git merge'

# 29. Merge with no fast-forward
alias gmnf='git merge --no-ff'

# 30. Abort merge
alias gma='git merge --abort'

# 31. Show merged branches
alias gbm='git branch --merged'

# 32. Pretty log
alias glog='git log --oneline --decorate --graph'

# 33. Pretty log with all branches
alias gloga='git log --oneline --decorate --graph --all'

# 34. Log with dates
alias glogd='git log --pretty=format:"%h %ad %s" --date=short'

# 35. Log with stats
alias glogs='git log --stat'

# 36. Log with patch
alias glogp='git log -p'

# 37. Show last commit
alias glast='git log -1 HEAD'

# 38. Show who changed what
alias gblame='git blame'

# 39. Show changes in last commit
alias gshow='git show'

# 41. List commits by author
alias gauthor='git log --author'

# 42. Search commits
alias gsearch='git log --all --grep'

# 43. Show branches with last commit
alias gbv='git branch -v'

# 44. Show branches with more info
alias gbvv='git branch -vv'

# 45. Reflog
alias grl='git reflog'

# 47. Show diff
alias gd='git diff'

# 48. Show diff of staged files
alias gds='git diff --staged'

# 49. Show diff with stats
alias gdst='git diff --stat'

# 51. Show word diff
alias gdw='git diff --word-diff'

# 55. Show diff in color
alias gdc='git diff --color-words'

# 53. Show files changed
alias gdfiles='git diff --name-only'

# 54. Show files changed with status
alias gdstat='git diff --name-status'

# 56. Show what changed in last commit
alias gdlc='git diff HEAD^ HEAD'

# 57. List tracked files
alias gls='git ls-files'

# 58. List untracked files
alias glsu='git ls-files --others'

# 60. Show contributors
alias gcontrib='git shortlog -sn'

# 61. Show file history
alias gfh='git log --follow -p --'

# 62. Stash changes
alias gst='git stash'

# 63. Stash with message
alias gstm='git stash push -m'

# 64. Stash including untracked
alias gstu='git stash -u'

# 65. Stash all (including ignored)
alias gsta='git stash -a'

# 66. List stashes
alias gstl='git stash list'

# 67. Show stash content
alias gsts='git stash show -p'

# 68. Apply last stash
alias gstap='git stash apply'

# 69. Pop last stash
alias gstpo='git stash pop'

# 70. Drop stash
alias gstd='git stash drop'

# 71. Clear all stashes
alias gstc='git stash clear'

# 72. Show remotes
alias gr='git remote'

# 73. Show remotes with URLs
alias grv='git remote -v'

# 74. Add remote
alias gra='git remote add'

# 75. Remove remote
alias grr='git remote remove'

# 77. Fetch from origin
alias gf='git fetch'

# 78. Fetch all remotes
alias gfa='git fetch --all'

# 79. Fetch with prune
alias gfp='git fetch --prune'

# 80. Clone repository
alias gcl='git clone'

# 81. Clone with depth
alias gcld='git clone --depth 1'

# 82. Reset to last commit (soft)
alias grss='git reset --soft HEAD~1'

# 83. Reset to last commit (mixed)
alias grsm='git reset HEAD~1'

# 84. Reset to last commit (hard)
alias grsh='git reset --hard HEAD~1'

# 85. Reset to origin
alias grso='git reset --hard origin/$(git branch --show-current)'

# 86. Unstage all files
alias gus='git reset HEAD'

# 87. Unstage specific file (requires file argument after --)
alias gusf='git reset HEAD --'

# 88. Clean untracked files (dry run)
alias gcn='git clean -n'

# 89. Clean untracked files
alias gcf='git clean -f'

# 90. Clean untracked files and directories
alias gcfd='git clean -fd'

# 91. Discard changes in file (requires file argument after --)
alias gdis='git checkout --'

# 92. Cherry-pick commit
alias gcp='git cherry-pick'

# 93. Cherry-pick and continue
alias gcpc='git cherry-pick --continue'

# 94. Cherry-pick abort
alias gcpa='git cherry-pick --abort'

# 95. Rebase interactive
alias grbi='git rebase -i'

# 96. Rebase continue
alias grbc='git rebase --continue'

# 97. Rebase abort
alias grba='git rebase --abort'

# 98. Rebase skip
alias grbs='git rebase --skip'

# 99. Show tags
alias gt='git tag'

# 100. Create tag
alias gta='git tag -a'

# 101. Push tags
alias gpt='git push --tags'

