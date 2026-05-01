#!/bin/bash
# ============================================================================
# Module: Cloud Deploy
# Description: Ghee shortcuts and utilities for Cloud Deploy.
# ============================================================================

# Cloud Deployment (Heroku, Vercel, Railway, Fly.io)

_GG_REGISTRY["vdeploy"]="vercel --prod ||| Deploy to Vercel production"
_GG_REGISTRY["vdev"]="vercel dev ||| Start local Vercel dev server"
_GG_REGISTRY["venvpull"]="vercel env pull .env.local ||| Pull Vercel environment variables to local"
_GG_REGISTRY["hdeploy"]="git push heroku main ||| Deploy to Heroku via git"
_GG_REGISTRY["hlogs"]="heroku logs --tail ||| Tail Heroku app logs"
_GG_REGISTRY["hbash"]="heroku run bash ||| Open bash shell on Heroku dyno"
_GG_REGISTRY["hrestart"]="heroku restart ||| Restart all Heroku dynos"
_GG_REGISTRY["rdeploy"]="railway up ||| Deploy to Railway"
_GG_REGISTRY["rlogs"]="railway logs ||| Show Railway deployment logs"
_GG_REGISTRY["fldeploy"]="fly deploy ||| Deploy to Fly.io"
_GG_REGISTRY["fllogs"]="fly logs ||| Show Fly.io logs"
_GG_REGISTRY["flssh"]="fly ssh console ||| SSH into Fly.io machine"
_GG_REGISTRY["flscale"]="fly scale count N ||| Scale Fly.io instance count"

# Vercel
alias vdeploy='vercel --prod'
alias vdev='vercel dev'
alias venv='vercel env pull .env.local'
alias vls='vercel ls'
alias vinspect='vercel inspect'

# Heroku
alias hdeploy='git push heroku main'
alias hlogs='heroku logs --tail'
alias hbash='heroku run bash'
alias hrestart='heroku restart'
alias henv='heroku config'
alias henvset='heroku config:set'
alias hscale='heroku ps:scale'
alias hopen='heroku open'

her_push() {
    local branch="${1:-main}"
    git push heroku "$branch"
}

# Railway
alias rdeploy='railway up'
alias rlogs='railway logs'
alias rshell='railway shell'
alias rvars='railway variables'

# Fly.io
alias fldeploy='fly deploy'
alias fllogs='fly logs'
alias flssh='fly ssh console'
alias flstatus='fly status'
alias flips='fly ips list'

flscale() {
    if [ -z "$1" ]; then echo "Usage: flscale <count>"; return 1; fi
    fly scale count "$1"
}
