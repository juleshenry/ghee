#!/bin/bash
# ============================================================================
# Module: Docker
# Description: Ghee shortcuts and utilities for Docker.
# ============================================================================

# Docker

_GG_REGISTRY["dps"]="docker ps ||| List running containers"]
_GG_REGISTRY["dpsa"]="docker ps -a ||| List all containers"]
_GG_REGISTRY["di"]="docker images ||| List images"]
_GG_REGISTRY["drm"]="docker rm ||| Remove a container"]
_GG_REGISTRY["drmi"]="docker rmi ||| Remove an image"]
_GG_REGISTRY["drmf"]="docker rm -f \$(docker ps -aq) ||| Force remove all containers"]
_GG_REGISTRY["drmia"]="docker rmi \$(docker images -q) ||| Remove all images"]
_GG_REGISTRY["dex"]="docker exec -it CONTAINER bash ||| Exec into container"]
_GG_REGISTRY["dl"]="docker logs -f CONTAINER ||| Follow container logs"]
_GG_REGISTRY["dstop"]="docker stop \$(docker ps -aq) ||| Stop all containers"]
_GG_REGISTRY["dprune"]="docker system prune -af ||| Prune everything (containers, images, networks)"]
_GG_REGISTRY["dc"]="docker compose ||| Docker Compose shortcut"]
_GG_REGISTRY["dcu"]="docker compose up -d ||| Compose up (detached)"]
_GG_REGISTRY["dcd"]="docker compose down ||| Compose down"]
_GG_REGISTRY["dcb"]="docker compose build ||| Compose build"]
_GG_REGISTRY["dcl"]="docker compose logs -f ||| Follow compose logs"]
_GG_REGISTRY["dcr"]="docker compose restart ||| Restart compose services"]
_GG_REGISTRY["dvls"]="docker volume ls ||| List volumes"]
_GG_REGISTRY["dnls"]="docker network ls ||| List networks"]
_GG_REGISTRY["dbuild"]="docker build -t NAME . ||| Build image from Dockerfile"]

# 102. List running containers
alias dps='docker ps'

# 103. List all containers
alias dpsa='docker ps -a'

# 104. List images
alias di='docker images'

# 105. Remove a container
alias drm='docker rm'

# 106. Remove an image
alias drmi='docker rmi'

# 107. Force remove all containers
alias drmf='docker rm -f $(docker ps -aq) 2>/dev/null'

# 108. Remove all images
alias drmia='docker rmi $(docker images -q) 2>/dev/null'

# 109. Exec into container
dex() {
    if [ -z "$1" ]; then
        echo "Usage: dex <container> [shell]"
        return 1
    fi
    docker exec -it "$1" "${2:-bash}"
}

# 110. Follow container logs
alias dl='docker logs -f'

# 111. Stop all running containers
alias dstop='docker stop $(docker ps -aq) 2>/dev/null'

# 112. Prune everything
alias dprune='docker system prune -af'

# 113. Docker Compose shortcut
alias dc='docker compose'

# 114. Compose up (detached)
alias dcu='docker compose up -d'

# 115. Compose down
alias dcd='docker compose down'

# 116. Compose build
alias dcb='docker compose build'

# 117. Follow compose logs
alias dcl='docker compose logs -f'

# 118. Restart compose services
alias dcr='docker compose restart'

# 119. List volumes
alias dvls='docker volume ls'

# 120. List networks
alias dnls='docker network ls'

# 121. Build image from Dockerfile
dbuild() {
    if [ -z "$1" ]; then
        echo "Usage: dbuild <image_name> [path]"
        return 1
    fi
    docker build -t "$1" "${2:-.}"
}

# Docker inspection and registry
_GG_REGISTRY["dstats"]="docker stats ||| Show live container resource usage"
_GG_REGISTRY["dinsp"]="docker inspect CONTAINER ||| Inspect container details"
_GG_REGISTRY["dsdf"]="docker system df ||| Show Docker disk usage"
_GG_REGISTRY["dtag"]="docker tag IMAGE:TAG NEW:TAG ||| Tag a Docker image"
_GG_REGISTRY["dpush"]="docker push IMAGE:TAG ||| Push image to registry"
_GG_REGISTRY["dpull"]="docker pull IMAGE ||| Pull image from registry"
_GG_REGISTRY["dcp"]="docker cp CONTAINER:SRC DEST ||| Copy files from container"

alias dstats='docker stats'
alias dinsp='docker inspect'
alias dsdf='docker system df'
alias dtag='docker tag'
alias dpush='docker push'
alias dpull='docker pull'
alias dcp='docker cp'

