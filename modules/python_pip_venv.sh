#!/bin/bash
# ============================================================================
# Module: Python Pip Venv
# Description: Ghee shortcuts and utilities for Python Pip Venv.
# ============================================================================

# Python / pip / venv

_GG_REGISTRY["py"]="python3 ||| Python3 shortcut"]
_GG_REGISTRY["py2"]="python2 ||| Python2 shortcut"]
_GG_REGISTRY["pip3i"]="pip3 install PACKAGE ||| pip install a package"]
_GG_REGISTRY["pipr"]="pip3 install -r requirements.txt ||| pip install from requirements"]
_GG_REGISTRY["pipf"]="pip3 freeze > requirements.txt ||| Freeze pip deps to requirements"]
_GG_REGISTRY["pipl"]="pip3 list ||| List installed pip packages"]
_GG_REGISTRY["pipo"]="pip3 list --outdated ||| List outdated pip packages"]
_GG_REGISTRY["pipu"]="pip3 install --upgrade PACKAGE ||| Upgrade a pip package"]
_GG_REGISTRY["pipun"]="pip3 uninstall PACKAGE ||| Uninstall a pip package"]
_GG_REGISTRY["venv"]="python3 -m venv venv ||| Create a virtual environment"]
_GG_REGISTRY["va"]="source venv/bin/activate ||| Activate venv"]
_GG_REGISTRY["vd"]="deactivate ||| Deactivate venv"]
_GG_REGISTRY["pt"]="pytest ||| Run pytest"]
_GG_REGISTRY["ptv"]="pytest -v ||| Run pytest verbose"]
_GG_REGISTRY["ptc"]="pytest --cov ||| Run pytest with coverage"]
_GG_REGISTRY["pym"]="python3 -m MODULE ||| Run Python module"]
_GG_REGISTRY["ipy"]="ipython ||| Launch IPython"]
_GG_REGISTRY["jnb"]="jupyter notebook ||| Launch Jupyter Notebook"]
_GG_REGISTRY["jlab"]="jupyter lab ||| Launch Jupyter Lab"]
_GG_REGISTRY["pide"]="pip3 install -e . ||| pip install in editable mode"]

# 226. Python3 shortcut
alias py='python3'

# 227. Python2 shortcut
alias py2='python2'

# 228. pip install
alias pip3i='pip3 install'

# 229. pip install requirements
alias pipr='pip3 install -r requirements.txt'

# 230. pip freeze to requirements
alias pipf='pip3 freeze > requirements.txt'

# 231. pip list installed
alias pipl='pip3 list'

# 232. pip list outdated
alias pipo='pip3 list --outdated'

# 233. pip upgrade package
alias pipu='pip3 install --upgrade'

# 234. pip uninstall
alias pipun='pip3 uninstall'

# 235. Create venv
alias venv='python3 -m venv venv'

# 236. Activate venv
alias va='source venv/bin/activate'

# 237. Deactivate venv
alias vd='deactivate'

# 238. pytest shortcut
alias pt='pytest'

# 239. pytest verbose
alias ptv='pytest -v'

# 240. pytest with coverage
alias ptc='pytest --cov'

# 241. Run Python module
alias pym='python3 -m'

# 242. IPython shortcut
alias ipy='ipython'

# 243. Jupyter notebook
alias jnb='jupyter notebook'

# 244. Jupyter lab
alias jlab='jupyter lab'

# 245. pip install editable
alias pide='pip3 install -e .'

# uv (fast pip replacement)
_GG_REGISTRY["uvi"]="uv pip install PACKAGE ||| Install with uv (fast pip)"
_GG_REGISTRY["uvr"]="uv pip install -r requirements.txt ||| Install requirements with uv"
_GG_REGISTRY["uvvenv"]="uv venv ||| Create venv with uv"

alias uvi='uv pip install'
alias uvr='uv pip install -r requirements.txt'
alias uvvenv='uv venv'

# Ruff (linter/formatter)
_GG_REGISTRY["rcheck"]="ruff check . ||| Lint with ruff"
_GG_REGISTRY["rfix"]="ruff check --fix . ||| Lint and autofix with ruff"
_GG_REGISTRY["rfmt"]="ruff format . ||| Format with ruff"

alias rcheck='ruff check .'
alias rfix='ruff check --fix .'
alias rfmt='ruff format .'

# Poetry
_GG_REGISTRY["poi"]="poetry install ||| Poetry install dependencies"
_GG_REGISTRY["poa"]="poetry add PACKAGE ||| Poetry add package"
_GG_REGISTRY["por"]="poetry run COMMAND ||| Poetry run command"
_GG_REGISTRY["pos"]="poetry shell ||| Poetry activate shell"

alias poi='poetry install'
alias poa='poetry add'
alias por='poetry run'
alias pos='poetry shell'

