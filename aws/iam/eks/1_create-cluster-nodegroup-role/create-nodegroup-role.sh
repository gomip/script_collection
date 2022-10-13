# input argument 
# 1. aws profile 
# 2. service (ex. rtb, rfind, ra, migo)
# 3. env (ex. eng, int, stg, prd)

#! /bin/bash
service="$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}"
env="$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1}"
app="$service$env"

aws iam create-role --role-name EKS-$app-Nodegroup-Role --assume-role-policy-document file://"cluster-node-trust-policy.json" --profile $1
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy --role-name EKS-$app-Nodegroup-Role --profile $1
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly --role-name EKS-$app-Nodegroup-Role --profile $1
