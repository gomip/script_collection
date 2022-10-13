# input argument
# service (ex. rtb, rfind, ra, migo)
# env (ex. eng, int, stg, prd)


helm repo add eks https://aws.github.io/eks-charts
helm repo update

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=$1-$2 \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller