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
