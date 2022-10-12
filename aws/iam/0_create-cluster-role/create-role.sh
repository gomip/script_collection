# input argument 
# 1. aws profile 
# 2. service (ex. rtb, rfind, ra, migo)
# 3. env (ex. eng, int, stg, prd)

#! /bin/bash
service=$2
env=$3

cluster="${service^}${env^}"
echo $cluster
# aws iam create-role --role-name [eksClusterRole] --assume-role-policy-document file://"cluster-trust-policy.json" --profile $1
# aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy --role-name [eksClusterRole]

aws iam create-role --role-name [eksnode] --assume-role-policy-document file://"cluster-node-trust-policy.json"
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy --role-name [eksnode]
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly --role-name [eksnode]
