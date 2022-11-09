# EKS 권한 
# 1. EKS
AWS EKS를 운영하기 위해 필요한 IAM 권한을 정리한 스크립트 집합이다.   
0~2 까지 총 3개의 디렉토리가 있는데 순서대로 진행해주면 된다. 

## 1-1. 0_create-cluster-role 
EKS를 운영하기 위해 필요한 권한 생성   

<b>사용방법</b>
```
./create-role.sh <프로파일> <서비스> <환경>

# 예제
./create-role.sh rsquare-dev valley eng
-> 생성되는 IAM Role = EKS-ValleyEng-Role
```

## 1-2. 1_create-cluster-nodegroup-role
EKS에서 사용되는 노드그룹에 대한 권한을 생성한다.

<b>사용방법</b>
```
./create-nodegroup-role.sh <프로파일> <서비스> <환경>

예제
./create-nodegroup-role.sh rsquare-dev valley eng
-> 생성되는 IAM Role = EKS-ValleyEng-Nodegroup-Role
```

## 1-3. 2_aws-load-balancer