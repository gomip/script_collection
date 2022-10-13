# input argument
# profile
# cluster name
# service (ex. rtb, rfind, ra, migo)
# env (ex. eng, int, stg, prd)

cluster=`(aws eks describe-cluster --name $2 --query "cluster.identity.oidc.issuer" --output text --profile=$1)`
oidc=`echo $cluster | awk -F '/id/' '{print $2}'`
region=`echo $cluster | awk -F '.' '{print $3}'`
echo "oidc   : $oidc"
echo "region : $region"

account=`aws sts get-caller-identity --query Account --output text --profile $1`
echo "account : $account"

# lb policy 생성
cat > load-balancer-role-trust-policy-$app.json << EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::$account:oidc-provider/oidc.eks.$region.amazonaws.com/id/$oidc"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.$region.amazonaws.com/id/$oidc:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
                }
            }
        }
    ]
}
EOF

service="$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}"
env="$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1}"
app="$service$env"

aws iam create-role --role-name AmazonEKSLoadBalancerControllerRole-EKS-$app --assume-role-policy-document file://"load-balancer-role-trust-policy-$app.json" --profile $1
aws iam attach-role-policy --policy-arn arn:aws:iam::$account:policy/AWSLoadBalancerControllerIAMPolicy-EKS-$app --role-name AmazonEKSLoadBalancerControllerRole-EKS-$app
