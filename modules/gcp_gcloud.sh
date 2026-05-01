#!/bin/bash
# ============================================================================
# Module: Gcp Gcloud
# Description: Ghee shortcuts and utilities for Gcp Gcloud.
# ============================================================================

# GCP / gcloud

_GG_REGISTRY["gcpid"]="gcloud config get-value project ||| Show current GCP project"]
_GG_REGISTRY["gcpset"]="gcloud config set project PROJECT ||| Set GCP project"]
_GG_REGISTRY["gcpls"]="gcloud compute instances list ||| List GCE instances"]
_GG_REGISTRY["gcpssh"]="gcloud compute ssh INSTANCE ||| SSH into GCE instance"]
_GG_REGISTRY["gcpgke"]="gcloud container clusters list ||| List GKE clusters"]
_GG_REGISTRY["gcpgkecreds"]="gcloud container clusters get-credentials CLUSTER ||| Get GKE kubeconfig"]
_GG_REGISTRY["gcpbq"]="bq ls ||| List BigQuery datasets"]
_GG_REGISTRY["gcpgsutil"]="gsutil ls ||| List GCS buckets"]
_GG_REGISTRY["gcpcp"]="gsutil cp FILE gs://BUCKET/ ||| Copy file to GCS"]
_GG_REGISTRY["gcpsync"]="gsutil -m rsync -r DIR gs://BUCKET/ ||| Sync directory to GCS"]
_GG_REGISTRY["gcprun"]="gcloud run services list ||| List Cloud Run services"]
_GG_REGISTRY["gcpfn"]="gcloud functions list ||| List Cloud Functions"]
_GG_REGISTRY["gcpsql"]="gcloud sql instances list ||| List Cloud SQL instances"]
_GG_REGISTRY["gcplog"]="gcloud logging read FILTER --limit=50 ||| Read GCP logs"]
_GG_REGISTRY["gcpauth"]="gcloud auth login ||| Authenticate with GCP"]

# 163. Show current GCP project
alias gcpid='gcloud config get-value project'

# 164. Set GCP project
alias gcpset='gcloud config set project'

# 165. List GCE instances
alias gcpls='gcloud compute instances list'

# 166. SSH into GCE instance
alias gcpssh='gcloud compute ssh'

# 167. List GKE clusters
alias gcpgke='gcloud container clusters list'

# 168. Get GKE kubeconfig
alias gcpgkecreds='gcloud container clusters get-credentials'

# 169. List BigQuery datasets
alias gcpbq='bq ls'

# 170. List GCS buckets
alias gcpgsutil='gsutil ls'

# 171. Copy file to GCS
alias gcpcp='gsutil cp'

# 172. Sync directory to GCS
alias gcpsync='gsutil -m rsync -r'

# 173. List Cloud Run services
alias gcprun='gcloud run services list'

# 174. List Cloud Functions
alias gcpfn='gcloud functions list'

# 175. List Cloud SQL instances
alias gcpsql='gcloud sql instances list'

# 176. Read GCP logs
alias gcplog='gcloud logging read --limit=50'

# 177. Authenticate with GCP
alias gcpauth='gcloud auth login'

