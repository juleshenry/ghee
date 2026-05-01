#!/bin/bash
# ============================================================================
# Module: Misc Devops
# Description: Ghee shortcuts and utilities for Misc Devops.
# ============================================================================

# Misc DevOps

_GG_REGISTRY["hup"]="helm upgrade --install RELEASE CHART ||| Helm upgrade/install"]
_GG_REGISTRY["hls"]="helm list ||| List Helm releases"]
_GG_REGISTRY["hdel"]="helm uninstall RELEASE ||| Uninstall Helm release"]
_GG_REGISTRY["ans"]="ansible-playbook PLAYBOOK.yml ||| Run Ansible playbook"]
_GG_REGISTRY["vup"]="vagrant up ||| Start Vagrant VM"]
_GG_REGISTRY["vsh"]="vagrant ssh ||| SSH into Vagrant VM"]
_GG_REGISTRY["vhalt"]="vagrant halt ||| Stop Vagrant VM"]

# 189. Helm upgrade/install
alias hup='helm upgrade --install'

# 190. List Helm releases
alias hls='helm list'

# 191. Uninstall Helm release
alias hdel='helm uninstall'

# 192. Run Ansible playbook
alias ans='ansible-playbook'

# 193. Start Vagrant VM
alias vup='vagrant up'

# 194. SSH into Vagrant VM
alias vsh='vagrant ssh'

# 195. Stop Vagrant VM
alias vhalt='vagrant halt'

