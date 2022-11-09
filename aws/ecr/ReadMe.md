# ECR 스크립트
# 1. copy-image
로컬 환경에서 AWS 간 도커 이미지 복사하는데 사용되는 스크립트다.    
ECR간 다이렉트 이미지 복사를 AWS에서 지원해주지 않기때문에 로컬 도커에 이미지를 pull 받아서 보내고자 하는 계정에 직접 push를 해줘야한다.   
그말인즉슨, 로컬에 도커가 켜있어야한다. 
## 1-1. 용어 정리
```SOURCE``` : 이미지 주인    
```DESTINATION``` : 이미지를 받을 aws 프로파일   

## 1-2. 로직정리   
1. Asia Pacific에서 사용가능한 리전 조회
2. Source 및 Destination에서 사용되는 리전 선택
3. Source 및 Destination 프로파일 지정
4. ECR 세팅
5. Source로부터 로컬에 이미지 pull
6. Destination ECR로 이미지 push

## 1-3. 사용방법
... 다시보니 source를 굳이 다시 받을 필요가 없는데 귀찮으니 새로 받자
```
./copy-image.sh <프로파일>

예. leapp상 프로파일 명이 rsquare라면
./copy-image.sh rsquare 
```