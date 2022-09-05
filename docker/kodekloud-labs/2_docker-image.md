1. how many images are available   
```docker images```
2. what is the size of ubunut image   
```docker images ```
3. what is the tag used for ubuntu   
```docker images ```
4. what is base image used for newly download code
```
cd webapp-color
cat Dockerfile
```
5. To what location within the container is the application code copied to during a Docker build?   
```cat Dockerfile```
6. When a container is created using the image built with this Dockerfile, what is the command used to RUN the application inside it.   
```cat Dockerfile```
7. what port is exposed   
```cat Dockerfile```
8. build a docker image with webapp-color   
```docker build --name webapp-color```
9. run instance of image webapp-color and publish port 8080 on container and 8282 on host    
```docker run -p 8282:8080 webapp-color```
10. host 연결
11. what is base os used by python:3.6 image?   
```docker run python:3.6```
12. what is the approximate size of webapp-color image?
```docker images```
13. 이미지를 줄이자
14. webapp-color and tag it lite, and make image smaller than 150MB.   
```
vi Dockerfile
> FROM python:3.6-alpine
!wq
docker build -t webapp-color:lite
```
15. Run an instance of the new image webapp-color:lite and publish port 8080 on the container to 8383 on the host.   
```docker run -p 8383:8080 webapp-color:lite```