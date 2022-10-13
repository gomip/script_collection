# input argument 
# 1. aws profile 
# 2. service (ex. rtb, rfind, ra, migo)
# 3. env (ex. eng, int, stg, prd)

#! /bin/bash
service="$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}"
env="$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1}"
policy="$service$env"

aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy-EKS-$policy --policy-document file://iam_policy.json