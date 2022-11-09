# 쉘스크립트 모음집
```
root                                            root
├ aws                                           ├ aws
|   ├ ecr                                       |   ├ ecr 서비스 관련 디렉토리
|   |   └ copy-image.sh                         |   |   └ AWS 계정에서 다른 계정에 이미지 복사
|   └ iam                                       |   └ iam 서비스 관련 디렉토리
|       | eks                                   |       | eks 에 필요한 권한 생성 스크립트
|       └ github-action                         |       └ github action ci 용 계정 생성   
└ github-action                                 └ github action 관련 디렉토리
    └ yaml                                          └ yaml 파싱해서 특정 value 가져오기
```
---
# 실행권한 부여
```
# 1. 모든 쉘스크립 실행 권한 부여
find . -name "*.sh" -exec chmod +x {} \;

# 2. 예시) copy-image.sh실행
cd ecr && ./copy-image.sh
```
---
# 목차
1. [ECR 이미지 복사](/aws/ecr/ReadMe.md)
2. [EKS 관련 권한 생성](/aws/iam/eks/ReadMe.md)
3. [깃헙액션에서 다른 계정으로 ECR 이미지 복사](/github-action/yaml/ReadMe.md)