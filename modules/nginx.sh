#!/bin/bash
# ============================================================================
# Module: Nginx
# Description: Ghee shortcuts and utilities for Nginx.
# ============================================================================

# Nginx

_GG_REGISTRY["ngt"]="sudo nginx -t ||| Test nginx config"]
_GG_REGISTRY["ngr"]="sudo nginx -s reload ||| Reload nginx"]
_GG_REGISTRY["ngstart"]="sudo systemctl start nginx ||| Start nginx"]
_GG_REGISTRY["ngstop"]="sudo systemctl stop nginx ||| Stop nginx"]
_GG_REGISTRY["ngrestart"]="sudo systemctl restart nginx ||| Restart nginx"]
_GG_REGISTRY["ngstatus"]="sudo systemctl status nginx ||| Nginx service status"]
_GG_REGISTRY["ngedit"]="sudo vi /etc/nginx/nginx.conf ||| Edit nginx config"]
_GG_REGISTRY["ngacc"]="sudo tail -f /var/log/nginx/access.log ||| Tail nginx access log"]
_GG_REGISTRY["ngerr"]="sudo tail -f /var/log/nginx/error.log ||| Tail nginx error log"]
_GG_REGISTRY["ngsites"]="ls /etc/nginx/sites-enabled/ ||| List nginx sites-enabled"]
_GG_REGISTRY["ngconf"]="sudo nginx -T ||| Dump full nginx config"]

# 308. Test nginx config
alias ngt='sudo nginx -t'

# 309. Reload nginx
alias ngr='sudo nginx -s reload'

# 310. Start nginx
alias ngstart='sudo systemctl start nginx 2>/dev/null || sudo nginx'

# 311. Stop nginx
alias ngstop='sudo systemctl stop nginx 2>/dev/null || sudo nginx -s stop'

# 312. Restart nginx
alias ngrestart='sudo systemctl restart nginx 2>/dev/null || sudo nginx -s quit && sudo nginx'

# 313. Nginx status
alias ngstatus='sudo systemctl status nginx 2>/dev/null || ps aux | grep nginx'

# 314. Edit nginx config
alias ngedit='sudo ${EDITOR:-vi} /etc/nginx/nginx.conf'

# 315. Tail nginx access log
alias ngacc='sudo tail -f /var/log/nginx/access.log'

# 316. Tail nginx error log
alias ngerr='sudo tail -f /var/log/nginx/error.log'

# 317. List nginx sites-enabled
alias ngsites='ls -la /etc/nginx/sites-enabled/ 2>/dev/null || ls -la /etc/nginx/conf.d/'

# 318. Nginx main config dump
alias ngconf='sudo nginx -T'

