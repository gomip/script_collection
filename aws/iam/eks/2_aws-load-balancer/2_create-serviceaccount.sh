# input argument
# profile
# service (ex. rtb, rfind, ra, migo)
# env (ex. eng, int, stg, prd)

service="$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}"
env="$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1}"
app="$service$env"

account=`aws sts get-caller-identity --query Account --output text --profile $1`
echo "account : $account"

cat > aws-load-balancer-controller-serviceaccount-$app.yaml << EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: aws-load-balancer-controller
  name: aws-load-balancer-controller
  namespace: kube-system
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::$account:role/AmazonEKSLoadBalancerControllerRole-EKS-$app
EOF

k apply -f aws-load-balancer-controller-service-account-$app.yaml