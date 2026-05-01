#!/bin/bash
# ============================================================================
# Module: Kubernetes
# Description: Ghee shortcuts and utilities for Kubernetes.
# ============================================================================

# Kubernetes

_GG_REGISTRY["k"]="kubectl ||| kubectl shortcut"]
_GG_REGISTRY["kgp"]="kubectl get pods ||| List pods"]
_GG_REGISTRY["kgpa"]="kubectl get pods --all-namespaces ||| List all pods across namespaces"]
_GG_REGISTRY["kgs"]="kubectl get svc ||| List services"]
_GG_REGISTRY["kgn"]="kubectl get nodes ||| List nodes"]
_GG_REGISTRY["kgd"]="kubectl get deployments ||| List deployments"]
_GG_REGISTRY["kgi"]="kubectl get ingress ||| List ingresses"]
_GG_REGISTRY["kgns"]="kubectl get namespaces ||| List namespaces"]
_GG_REGISTRY["kga"]="kubectl get all ||| List all resources"]
_GG_REGISTRY["kdp"]="kubectl describe pod POD ||| Describe a pod"]
_GG_REGISTRY["kds"]="kubectl describe svc SVC ||| Describe a service"]
_GG_REGISTRY["kdd"]="kubectl describe deployment DEP ||| Describe a deployment"]
_GG_REGISTRY["kl"]="kubectl logs -f POD ||| Follow pod logs"]
_GG_REGISTRY["klp"]="kubectl logs -f POD -p ||| Previous pod logs"]
_GG_REGISTRY["kex"]="kubectl exec -it POD -- bash ||| Exec into a pod"]
_GG_REGISTRY["kaf"]="kubectl apply -f FILE ||| Apply a manifest"]
_GG_REGISTRY["kdf"]="kubectl delete -f FILE ||| Delete from manifest"]
_GG_REGISTRY["kctx"]="kubectl config get-contexts ||| Show kube contexts"]
_GG_REGISTRY["kuse"]="kubectl config use-context CTX ||| Switch kube context"]
_GG_REGISTRY["kns"]="kubectl config set-context --current --namespace=NS ||| Set default namespace"]
_GG_REGISTRY["kpf"]="kubectl port-forward POD LOCAL:REMOTE ||| Port-forward to a pod"]
_GG_REGISTRY["kscale"]="kubectl scale deployment DEP --replicas=N ||| Scale a deployment"]
_GG_REGISTRY["krollout"]="kubectl rollout status deployment DEP ||| Check rollout status"]
_GG_REGISTRY["krestart"]="kubectl rollout restart deployment DEP ||| Restart a deployment"]
_GG_REGISTRY["ktop"]="kubectl top pods ||| Pod resource usage"]
_GG_REGISTRY["ktopn"]="kubectl top nodes ||| Node resource usage"]

# 122. kubectl shortcut
alias k='kubectl'

# 123. List pods
alias kgp='kubectl get pods'

# 124. List all pods across namespaces
alias kgpa='kubectl get pods --all-namespaces'

# 125. List services
alias kgs='kubectl get svc'

# 126. List nodes
alias kgn='kubectl get nodes'

# 127. List deployments
alias kgd='kubectl get deployments'

# 128. List ingresses
alias kgi='kubectl get ingress'

# 129. List namespaces
alias kgns='kubectl get namespaces'

# 130. List all resources
alias kga='kubectl get all'

# 131. Describe a pod
alias kdp='kubectl describe pod'

# 132. Describe a service
alias kds='kubectl describe svc'

# 133. Describe a deployment
alias kdd='kubectl describe deployment'

# 134. Follow pod logs
alias kl='kubectl logs -f'

# 135. Previous pod logs
alias klp='kubectl logs -f -p'

# 136. Exec into a pod
kex() {
    if [ -z "$1" ]; then
        echo "Usage: kex <pod> [shell]"
        return 1
    fi
    kubectl exec -it "$1" -- "${2:-bash}"
}

# 137. Apply a manifest
alias kaf='kubectl apply -f'

# 138. Delete from manifest
alias kdf='kubectl delete -f'

# 139. Show kube contexts
alias kctx='kubectl config get-contexts'

# 140. Switch kube context
alias kuse='kubectl config use-context'

# 141. Set default namespace
kns() {
    if [ -z "$1" ]; then
        echo "Usage: kns <namespace>"
        return 1
    fi
    kubectl config set-context --current --namespace="$1"
}

# 142. Port-forward to a pod
alias kpf='kubectl port-forward'

# 143. Scale a deployment
kscale() {
    if [ -z "$2" ]; then
        echo "Usage: kscale <deployment> <replicas>"
        return 1
    fi
    kubectl scale deployment "$1" --replicas="$2"
}

# 144. Check rollout status
alias krollout='kubectl rollout status deployment'

# 145. Restart a deployment
alias krestart='kubectl rollout restart deployment'

# 146. Pod resource usage
alias ktop='kubectl top pods'

# 147. Node resource usage
alias ktopn='kubectl top nodes'

