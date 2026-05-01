#!/bin/bash
# ============================================================================
# Module: Aws Cli
# Description: Ghee shortcuts and utilities for Aws Cli.
# ============================================================================

# AWS CLI

_GG_REGISTRY["awsid"]="aws sts get-caller-identity ||| Show current AWS identity"]
_GG_REGISTRY["awsls"]="aws s3 ls ||| List S3 buckets"]
_GG_REGISTRY["awscp"]="aws s3 cp FILE s3://BUCKET/ ||| Copy file to S3"]
_GG_REGISTRY["awssync"]="aws s3 sync DIR s3://BUCKET/ ||| Sync directory to S3"]
_GG_REGISTRY["awsec2"]="aws ec2 describe-instances ||| List EC2 instances"]
_GG_REGISTRY["awsecr"]="aws ecr get-login-password | docker login ||| ECR docker login"]
_GG_REGISTRY["awslam"]="aws lambda list-functions ||| List Lambda functions"]
_GG_REGISTRY["awslog"]="aws logs tail LOG_GROUP --follow ||| Tail CloudWatch logs"]
_GG_REGISTRY["awseb"]="aws elasticbeanstalk describe-environments ||| List EB environments"]
_GG_REGISTRY["awscf"]="aws cloudformation list-stacks ||| List CloudFormation stacks"]
_GG_REGISTRY["awseks"]="aws eks list-clusters ||| List EKS clusters"]
_GG_REGISTRY["awsrds"]="aws rds describe-db-instances ||| List RDS instances"]
_GG_REGISTRY["awsssm"]="aws ssm start-session --target INSTANCE ||| SSM session to instance"]
_GG_REGISTRY["awswho"]="aws iam get-user ||| Show current IAM user"]
_GG_REGISTRY["awsregions"]="aws ec2 describe-regions --output table ||| List all AWS regions"]

# 148. Show current AWS identity
alias awsid='aws sts get-caller-identity'

# 149. List S3 buckets
alias awsls='aws s3 ls'

# 150. Copy file to S3
alias awscp='aws s3 cp'

# 151. Sync directory to S3
alias awssync='aws s3 sync'

# 152. List EC2 instances
alias awsec2='aws ec2 describe-instances --query "Reservations[].Instances[].[InstanceId,State.Name,Tags[?Key==\`Name\`].Value|[0]]" --output table'

# 153. ECR docker login
awsecr() {
    local region="${1:-us-east-1}"
    local account
    account=$(aws sts get-caller-identity --query Account --output text)
    aws ecr get-login-password --region "$region" | docker login --username AWS --password-stdin "${account}.dkr.ecr.${region}.amazonaws.com"
}

# 154. List Lambda functions
alias awslam='aws lambda list-functions --query "Functions[].FunctionName" --output table'

# 155. Tail CloudWatch logs
alias awslog='aws logs tail --follow'

# 156. List Elastic Beanstalk environments
alias awseb='aws elasticbeanstalk describe-environments --query "Environments[].[EnvironmentName,Status]" --output table'

# 157. List CloudFormation stacks
alias awscf='aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE --query "StackSummaries[].StackName" --output table'

# 158. List EKS clusters
alias awseks='aws eks list-clusters --output table'

# 159. List RDS instances
alias awsrds='aws rds describe-db-instances --query "DBInstances[].[DBInstanceIdentifier,DBInstanceStatus,Engine]" --output table'

# 160. SSM session to instance
alias awsssm='aws ssm start-session --target'

# 161. Show current IAM user
alias awswho='aws iam get-user'

# 162. List all AWS regions
alias awsregions='aws ec2 describe-regions --query "Regions[].RegionName" --output table'

