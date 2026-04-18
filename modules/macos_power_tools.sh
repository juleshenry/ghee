#!/bin/bash
# ============================================================================
# Module: Macos Power Tools
# Description: Ghee shortcuts and utilities for Macos Power Tools.
# ============================================================================

# macOS Power Tools

_GG_REGISTRY["caffeinate"]="caffeinate -d ||| Prevent Mac from sleeping"
_GG_REGISTRY["hidefiles"]="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder ||| Hide hidden files in Finder"
_GG_REGISTRY["showfiles"]="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder ||| Show hidden files in Finder"
_GG_REGISTRY["flushui"]="killall Dock; killall Finder ||| Restart Dock and Finder to fix UI glitches"
_GG_REGISTRY["copyurl"]="osascript -e 'tell app \"Safari\" to get URL of front document' | pbcopy ||| Copy URL of active Safari tab"
_GG_REGISTRY["copycwd"]="pwd | tr -d '\n' | pbcopy ||| Copy current directory path to clipboard"
_GG_REGISTRY["locks"]="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend ||| Lock mac screen immediately"
_GG_REGISTRY["emptytrash"]="rm -rf ~/.Trash/* ||| Empty the Trash immediately"

alias caffeinate='caffeinate -d'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias flushui='killall Dock; killall Finder'
alias copyurl='osascript -e "tell app \"Safari\" to get URL of front document" | pbcopy; echo "Safari URL copied to clipboard!"'
alias copycwd='pwd | tr -d "\n" | pbcopy; echo "Copied $(pwd) to clipboard!"'
alias locks='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend 2>/dev/null || pmset displaysleepnow'
alias emptytrash='rm -rf ~/.Trash/*; echo "Trash emptied."'

# App launching and launchd
_GG_REGISTRY["opena"]="open -a APPLICATION ||| Open a macOS application"
_GG_REGISTRY["lctl"]="launchctl list ||| List launchd services"
_GG_REGISTRY["lctlstart"]="launchctl load PLIST ||| Load/start a launchd service"
_GG_REGISTRY["lctlstop"]="launchctl unload PLIST ||| Unload/stop a launchd service"

alias opena='open -a'
alias lctl='launchctl list'
alias lctlstart='launchctl load'
alias lctlstop='launchctl unload'

# Disk and network utilities
_GG_REGISTRY["dutil"]="diskutil list ||| List disks and partitions"
_GG_REGISTRY["netsetup"]="networksetup -listallhardwareports ||| List network interfaces"
_GG_REGISTRY["wifion"]="networksetup -setairportpower en0 on ||| Turn WiFi on"
_GG_REGISTRY["wifioff"]="networksetup -setairportpower en0 off ||| Turn WiFi off"
_GG_REGISTRY["wifils"]="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s ||| Scan WiFi networks"
_GG_REGISTRY["sysinfo"]="system_profiler SPHardwareDataType ||| Show Mac hardware info"
_GG_REGISTRY["defaults_ls"]="defaults domains | tr ',' '\n' ||| List all macOS defaults domains"

alias dutil='diskutil list'
alias netsetup='networksetup -listallhardwareports'
alias wifion='networksetup -setairportpower en0 on'
alias wifioff='networksetup -setairportpower en0 off'
alias wifils='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s'
alias sysinfo='system_profiler SPHardwareDataType'
alias defaults_ls='defaults domains | tr "," "\n"'
