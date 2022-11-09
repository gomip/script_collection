# input argument
# 1. aws profile
# 2. service (ex. rtb, rfind, ra, migo)

service="$(tr '[:lower:]' '[:upper:]' <<< ${2:0:1})${2:1}"
env="$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1}"
application="$service$env"

aws iam create-policy --policy-name deploy-$application-policy --policy-document file://ecr-trust-policy.json --profile $1
aws iam create-user --user-name deploy-$application --profile $1
aws iam add-user-to-group --group-name ci-cd-bot-group --user-name deploy-$application --profile $1
account=`aws sts get-caller-identity --query Account --output text --profile $1`
echo "account : $account"
aws iam attach-user-policy --user-name deploy-$application --policy-arn arn:aws:iam::$account:policy/deploy-$application-policy --profile $1
aws iam create-access-key --user-name deploy-$application --profile $1