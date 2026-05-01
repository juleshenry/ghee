#!/bin/bash
# ============================================================================
# Module: Terraform
# Description: Ghee shortcuts and utilities for Terraform.
# ============================================================================

# Terraform

_GG_REGISTRY["tf"]="terraform ||| Terraform shortcut"]
_GG_REGISTRY["tfi"]="terraform init ||| Initialize Terraform"]
_GG_REGISTRY["tfp"]="terraform plan ||| Plan changes"]
_GG_REGISTRY["tfa"]="terraform apply ||| Apply changes"]
_GG_REGISTRY["tfaa"]="terraform apply -auto-approve ||| Apply without prompt"]
_GG_REGISTRY["tfd"]="terraform destroy ||| Destroy infrastructure"]
_GG_REGISTRY["tfs"]="terraform state list ||| List state resources"]
_GG_REGISTRY["tfo"]="terraform output ||| Show outputs"]
_GG_REGISTRY["tfv"]="terraform validate ||| Validate config"]
_GG_REGISTRY["tff"]="terraform fmt -recursive ||| Format all .tf files"]
_GG_REGISTRY["tfw"]="terraform workspace list ||| List workspaces"]

# 178. Terraform shortcut
alias tf='terraform'

# 179. Initialize Terraform
alias tfi='terraform init'

# 180. Plan changes
alias tfp='terraform plan'

# 181. Apply changes
alias tfa='terraform apply'

# 182. Apply without prompt
alias tfaa='terraform apply -auto-approve'

# 183. Destroy infrastructure
alias tfd='terraform destroy'

# 184. List state resources
alias tfs='terraform state list'

# 185. Show outputs
alias tfo='terraform output'

# 186. Validate config
alias tfv='terraform validate'

# 187. Format all .tf files
alias tff='terraform fmt -recursive'

# 188. List workspaces
alias tfw='terraform workspace list'

