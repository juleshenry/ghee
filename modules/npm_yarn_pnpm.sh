#!/bin/bash
# ============================================================================
# Module: Npm Yarn Pnpm
# Description: Ghee shortcuts and utilities for Npm Yarn Pnpm.
# ============================================================================

# npm / yarn / pnpm

_GG_REGISTRY["ni"]="npm install ||| npm install"]
_GG_REGISTRY["nid"]="npm install --save-dev ||| npm install as dev dependency"]
_GG_REGISTRY["nig"]="npm install -g ||| npm install globally"]
_GG_REGISTRY["nrd"]="npm run dev ||| npm run dev server"]
_GG_REGISTRY["nrb"]="npm run build ||| npm run build"]
_GG_REGISTRY["nrs"]="npm run start ||| npm run start"]
_GG_REGISTRY["nrt"]="npm run test ||| npm run test"]
_GG_REGISTRY["nrl"]="npm run lint ||| npm run lint"]
_GG_REGISTRY["nls"]="npm list --depth=0 ||| List top-level npm packages"]
_GG_REGISTRY["nout"]="npm outdated ||| Show outdated npm packages"]
_GG_REGISTRY["nup"]="npm update ||| Update npm packages"]
_GG_REGISTRY["naf"]="npm audit fix ||| Fix npm audit vulnerabilities"]
_GG_REGISTRY["ncc"]="npm cache clean --force ||| Clear npm cache"]
_GG_REGISTRY["ninit"]="npm init -y ||| Initialize new npm project"]
_GG_REGISTRY["nx"]="npx ||| npx shortcut"]
_GG_REGISTRY["yi"]="yarn install ||| Yarn install dependencies"]
_GG_REGISTRY["ya"]="yarn add PACKAGE ||| Yarn add package"]
_GG_REGISTRY["yad"]="yarn add --dev PACKAGE ||| Yarn add dev dependency"]
_GG_REGISTRY["yrd"]="yarn dev ||| Yarn dev server"]
_GG_REGISTRY["yrb"]="yarn build ||| Yarn build"]
_GG_REGISTRY["yrs"]="yarn start ||| Yarn start"]
_GG_REGISTRY["yrt"]="yarn test ||| Yarn test"]
_GG_REGISTRY["yga"]="yarn global add PACKAGE ||| Yarn global install"]
_GG_REGISTRY["pi"]="pnpm install ||| pnpm install dependencies"]
_GG_REGISTRY["pad"]="pnpm add PACKAGE ||| pnpm add package"]
_GG_REGISTRY["padd"]="pnpm add -D PACKAGE ||| pnpm add dev dependency"]
_GG_REGISTRY["prd"]="pnpm dev ||| pnpm dev server"]
_GG_REGISTRY["prb"]="pnpm build ||| pnpm build"]
_GG_REGISTRY["prs"]="pnpm start ||| pnpm start"]
_GG_REGISTRY["prt"]="pnpm test ||| pnpm test"]

# 196. npm install
alias ni='npm install'

# 197. npm install save-dev
alias nid='npm install --save-dev'

# 198. npm install global
alias nig='npm install -g'

# 199. npm run dev
alias nrd='npm run dev'

# 200. npm run build
alias nrb='npm run build'

# 201. npm run start
alias nrs='npm run start'

# 202. npm run test
alias nrt='npm run test'

# 203. npm run lint
alias nrl='npm run lint'

# 204. npm list (top-level)
alias nls='npm list --depth=0'

# 205. npm outdated
alias nout='npm outdated'

# 206. npm update
alias nup='npm update'

# 207. npm audit fix
alias naf='npm audit fix'

# 208. npm cache clean
alias ncc='npm cache clean --force'

# 209. npm init -y
alias ninit='npm init -y'

# 210. npx shortcut
alias nx='npx'

# 211. yarn install
alias yi='yarn install'

# 212. yarn add
alias ya='yarn add'

# 213. yarn add dev
alias yad='yarn add --dev'

# 214. yarn dev
alias yrd='yarn dev'

# 215. yarn build
alias yrb='yarn build'

# 216. yarn start
alias yrs='yarn start'

# 217. yarn test
alias yrt='yarn test'

# 218. yarn global add
alias yga='yarn global add'

# 219. pnpm install
alias pi='pnpm install'

# 220. pnpm add
alias pad='pnpm add'

# 221. pnpm add dev
alias padd='pnpm add -D'

# 222. pnpm dev
alias prd='pnpm dev'

# 223. pnpm build
alias prb='pnpm build'

# 224. pnpm start
alias prs='pnpm start'

# 225. pnpm test
alias prt='pnpm test'

