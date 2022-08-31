#! /bin/bash

function handle_option() {
  cur=-1
  while [[ $cur -le 0 ]] || [[ $cur -ge `expr $2 + 1` ]]
  do
    read -ep "Select $1 : " cur
    if [[ $cur -le 0 ]] || [[ $cur -ge `expr $2 + 1` ]]
    then
      echo "Please select proper option"
    fi
  done
  # 배열의 인덱스는 0부터니깐 -1 해준다
  return `expr $cur - 1`
}

function handle_array() {
  size=$1
  shift
  arr=("$@")
  for (( i=0;i<$size;i++ ))
    do
      echo "`expr $i + 1`) ${arr[$i]}"
    done
}

# Get All Regions starts with ap(Asia Pacific) -------------------------------------------------------------------------------------------------------
declare -a REGION=(`aws ec2 describe-regions --profile rsquare-asis --filters "Name=region-name,Values=*ap*" --query "Regions[].{Name:RegionName}" --output text | sort -u`)
SIZE=${#REGION[@]}
echo "=================================================="
echo "[1-1] Asia Pacific Region       : $SIZE"
echo "=================================================="

# Get All Region Name using elements in REGION -------------------------------------------------------------------------------------------------------
REGION_NAME=()
for(( i=0;i<$SIZE;i++))
do
  REGION_NAME+=(`aws ssm get-parameter --name /aws/service/global-infrastructure/regions/${REGION[$i]}/longName --query "Parameter.Value" --output text | sed 's/.*(\(.*\))/\1/'`)
done

# List all available region --------------------------------------------------------------------------------------------------------------------------
for (( i=0;i<$SIZE;i++));
do
  echo "`expr $i + 1`) ${REGION[$i]}(${REGION_NAME[$i]})"
done
echo "=================================================="

# Get user input for source_region -------------------------------------------------------------------------------------------------------------------
echo -n "[2-1] "
handle_option "Source region" $SIZE
SOURCE_REGION=$?

# Get user input for destination_region --------------------------------------------------------------------------------------------------------------
echo -n "[2-2] "
handle_option "Destination region" $SIZE
DESTINATION_REGION=$?
echo "=================================================="

# Set profile for source and destination to use aws cli ----------------------------------------------------------------------------------------------
read -ep "[3-1] Enter source profile      : " SOURCE_PROFILE
read -ep "[3-2] Enter destination profile : " DESTINATION_PROFILE
echo "=================================================="

# Set ecr base path for source and destination -------------------------------------------------------------------------------------------------------
echo "[4-1] Setting account           : Source"
SOURCE_ACCOUNT=`aws sts get-caller-identity --query Account --output text --profile $SOURCE_PROFILE`
SOURCE_PATH="$SOURCE_ACCOUNT.dkr.ecr.${REGION[$SOURCE_REGION]}.amazonaws.com"
echo "Path : $SOURCE_PATH"

echo "[4-2] Setting account           : Destination"
DESTINATION_ACCOUNT=`aws sts get-caller-identity --query Account --output text --profile $DESTINATION_PROFILE`
DESTINATION_PATH="$DESTINATION_ACCOUNT.dkr.ecr.${REGION[$DESTINATION_REGION]}.amazonaws.com"
echo "Path : $DESTINATION_PATH"
echo "=================================================="

# Pull image from Source account ---------------------------------------------------------------------------------------------------------------------
echo "[5-1] Docker Login              : Source"
# Login Source
aws ecr get-login-password --profile $SOURCE_PROFILE --region ${REGION[$SOURCE_REGION]} | docker login --username AWS --password-stdin $SOURCE_PATH

# List all repositories in source
echo
echo "[5-2] Get Repository from ECR"
SOURCE_REPOSITORY=(`aws ecr describe-repositories --query 'repositories[].repositoryUri' --output text --region ${REGION[$SOURCE_REGION]} --profile $SOURCE_PROFILE`)
SOURCE_REPOSITORY_SIZE=${#SOURCE_REPOSITORY[@]}
handle_array $SOURCE_REPOSITORY_SIZE "${SOURCE_REPOSITORY[@]}"

echo -n "[5-3] "
handle_option Repository $SOURCE_REPOSITORY_SIZE
SOURCE_REPOSITORY_OPT=$?

echo "[5-4] Get last 30 image tags"
IMAGE_NAME=$(echo ${SOURCE_REPOSITORY[$SOURCE_REPOSITORY_OPT]} | cut -d '/' -f 2)

# Select image tag
IMAGE_TAGS=(`aws ecr describe-images --repository-name $IMAGE_NAME --query 'imageDetails[].imageTags' --output text --profile $SOURCE_PROFILE --region ${REGION[$SOURCE_REGION]} | sort -nr | head -30`)
IMAGE_TAGS_SIZE=${#IMAGE_TAGS[@]}
handle_array $IMAGE_TAGS_SIZE "${IMAGE_TAGS[@]}"
echo -n "[5-4] "
handle_option Tag $IMAGE_TAGS_SIZE
IMAGE_TAGS_OPT=$?

# docker pull
echo
echo "[5-5] Pull Image"
docker pull $SOURCE_PATH/$IMAGE_NAME:${IMAGE_TAGS[$IMAGE_TAGS_OPT]}
docker tag $SOURCE_PATH/$IMAGE_NAME:${IMAGE_TAGS[$IMAGE_TAGS_OPT]} $DESTINATION_PATH/$IMAGE_NAME:${IMAGE_TAGS[$IMAGE_TAGS_OPT]}
echo "=================================================="

# Push image to Destination account ------------------------------------------------------------------------------------
# destination profile login
echo "[6-1] Docker Login              : Destination"
aws ecr get-login-password --profile $DESTINATION_PROFILE --region ${REGION[$DESTINATION_REGION]} | docker login --username AWS --password-stdin $DESTINATION_PATH

echo
echo "[6-2] Check if repository exist, else create repository"
ARRAY_REPOSITORY=(`aws ecr describe-repositories --profile $DESTINATION_PROFILE --region ${REGION[$DESTINATION_REGION]} --query "repositories[].{Name:repositoryName}" --output text`)
if [[ ! ${ARRAY_REPOSITORY[*]} =~ $IMAGE_NAME ]]
then
  echo "Create Repository"
  aws ecr create-repository --repository-name $IMAGE_NAME  --profile $DESTINATION_PROFILE --region ${REGION[$DESTINATION_REGION]}
else
  echo "Repository Exists"
fi

echo
echo "[6-3] Push Image"
docker push $DESTINATION_PATH/$IMAGE_NAME:${IMAGE_TAGS[$IMAGE_TAGS_OPT]}
echo

# Remove Image from local ----------------------------------------------------------------------------------------------
echo "Remove local image"
docker image rm -f $SOURCE_PATH/$IMAGE_NAME:${IMAGE_TAGS[$IMAGE_TAGS_OPT]}
docker image rm -f $DESTINATION_PATH/$IMAGE_NAME:${IMAGE_TAGS[$IMAGE_TAGS_OPT]}

echo
echo "finish"
