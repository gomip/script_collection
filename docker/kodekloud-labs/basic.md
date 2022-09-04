1. check version   
```docker version```
2. check running containers   
```docker ps```
3. check available images   
```docker images```
4. run redis image   
```docker run redis```
5. stop the redis container   
```docker stop image```
6. check running containers   
```docker ps```
7. check just created containers   
```docker ps```
8. check all running and stop containers   
```docker ps -a ```
9. image used to run nginx-1 container   
```docker ps -a ```
10. what is the name of container created with ubuntu image      
```docker ps -a```
11. id of container using alpine image and is not running   
```docker ps -a```
12. what is the state of the stopped alpine container   
```docker ps -a```
13. delete all containers from docker host bot running and not running   
```
docker ps -a
docker stop image
docker rm container
docker ps -a
```
14. delete ubuntu images   
```docker rmi ubuntu```
15. docker pull nginx:1.14-alpine   
```docker pull nginx:1.14-alpine```
16. run container with nginx:1.14-alpine and name it webapp   
```docker run --name webapp nginx:1.14-alpine```
17. delete all images on host
```
# check container
docker ps -a
# stop container
docker stop container
# delete image
docker rmi image
```