1. check how many containers are running   
```docker ps ```
2. what is image used   
```docker ps ```
3. how many ports are published   
```docker ps ```
4. which of the below ports are exposed on container   
```
docker ps
-> 뒤의 포트들 
```
5. which of the below ports are published on host   
```
docker ps
-> 앞의 포트들
```
6. Run an instance of kodekloud/simple-webapp with a tag blue and map port 8080 on the container to 38282 on the host.   
```
docker run -p 38282:8080 kodekloud/simple-webapp:blue
```