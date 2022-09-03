# 이미지 가져오기
redis의 가장 latest 태그를 가져오게된다.
```
docker run redis
```
특정버전을 가져오고 싶으면 Tag를 사용하면된다 . docker hub에서 지원되는 태그 정보를 볼수있다   
```
docker run redis:4.0
```

docker 컨테이너는 기본적으로 standard input을 받을수가 없다.   
값을 받아서 쓰고 싶으면 내 호스트와 컨테이너를 연결해줘야한다.   

- <b>- i</b> : Interactive mode 즉 입력을 받을수 있게한다.
```
docker run -i kodekloud
```
예제에서 보면 이름이 뭔지 물어보는 코드가 있는데 -i 태그만 넣어서는 아무일도 일어나지 않을거다. 
- <b>- t</b> : Pseudo Terminal 컨테이너 터미널과 연결시켜준다
```
docker run -it kodekloud/simple-prompt-docker
```
- port
```
docker run kodekloud/webapp
```
웹앱을 실행하면 서버에서 돌아가는것을 확인할 수 있다.   
웹에서 접근하기 위해서는 도커 컨테이너의 아이피 사용, 하지만 이건 호스트에서만 접근할 수 있다. 도커 호스트 외부에 있는 사용자가 접근하기 
위해서는 도커 호스트를 사용하면 된다. 그러기 위해서는 도커 컨테이너의 포트를 호스트와 연결해줘야한다.
```
docker run -p 80:5000 kodekloud/simple-webapp
```
도커 호스트의 80을 컨테이너의 5000번으로 연결해준다. 그리고 컨테이너의 포트는 중복이여도 상관없다. 어차피 다른 인스턴스기 때문에
가지게 되는 포트번호도 다르게된다. 도커 호스트의 포트만 다르면된다.
- volume mapping
도커 컨테이너에서 데이터를 어떻게 유지하는가...각각의 컨테이너들은 독립된 파일시스템을 가지게 된다. 컨테이너를 지우게 되면 그 컨테이너가 가지던
모든 데이터를 삭제시킨다.
```
docker stop mysql
docker rm mysql
```
그러면 어떻게 해당 데이터들을 유지하는가?
```
docker run -v /opt/datadir:/var/lib/mysql mysql
```
/opt/dir의 경로를 컨테이너에 있는 /var/lib/mysql로 매핑해준다.
- docker inspect
json 포맷으로 컨테이너의 상세 정보를 출력해준다.
- docker logs
```docker logs [container name]```
- 
