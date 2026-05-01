#!/bin/bash
# ============================================================================
# Module: Systemd Services
# Description: Ghee shortcuts and utilities for Systemd Services.
# ============================================================================

# Systemd / Services

_GG_REGISTRY["scs"]="sudo systemctl status SERVICE ||| Show service status"]
_GG_REGISTRY["scstart"]="sudo systemctl start SERVICE ||| Start a service"]
_GG_REGISTRY["scstop"]="sudo systemctl stop SERVICE ||| Stop a service"]
_GG_REGISTRY["screstart"]="sudo systemctl restart SERVICE ||| Restart a service"]
_GG_REGISTRY["scenable"]="sudo systemctl enable SERVICE ||| Enable service at boot"]
_GG_REGISTRY["scdisable"]="sudo systemctl disable SERVICE ||| Disable service at boot"]
_GG_REGISTRY["screload"]="sudo systemctl reload SERVICE ||| Reload service config"]
_GG_REGISTRY["scdaemon"]="sudo systemctl daemon-reload ||| Reload systemd daemon"]
_GG_REGISTRY["jctl"]="sudo journalctl -f ||| Follow system journal"]
_GG_REGISTRY["jctlu"]="sudo journalctl -u SERVICE ||| Journal for a specific unit"]
_GG_REGISTRY["jctlt"]="sudo journalctl --since today ||| Journal since today"]
_GG_REGISTRY["scls"]="systemctl list-units --type=service ||| List active services"]
_GG_REGISTRY["scfail"]="systemctl --failed ||| List failed services"]
_GG_REGISTRY["scactive"]="systemctl is-active SERVICE ||| Check if service is active"]
_GG_REGISTRY["scenabled"]="systemctl is-enabled SERVICE ||| Check if service is enabled"]

# 246. systemctl status
alias scs='sudo systemctl status'

# 247. systemctl start
alias scstart='sudo systemctl start'

# 248. systemctl stop
alias scstop='sudo systemctl stop'

# 249. systemctl restart
alias screstart='sudo systemctl restart'

# 250. systemctl enable
alias scenable='sudo systemctl enable'

# 251. systemctl disable
alias scdisable='sudo systemctl disable'

# 252. systemctl reload
alias screload='sudo systemctl reload'

# 253. systemctl daemon-reload
alias scdaemon='sudo systemctl daemon-reload'

# 254. journalctl follow
alias jctl='sudo journalctl -f'

# 255. journalctl for a unit
alias jctlu='sudo journalctl -u'

# 256. journalctl since today
alias jctlt='sudo journalctl --since today'

# 257. systemctl list-units
alias scls='systemctl list-units --type=service'

# 258. systemctl list-failed
alias scfail='systemctl --failed'

# 259. systemctl is-active
alias scactive='systemctl is-active'

# 260. systemctl is-enabled
alias scenabled='systemctl is-enabled'

