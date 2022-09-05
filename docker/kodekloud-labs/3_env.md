1. Inspect the environment variables set on the running container and identify the value set to the APP_COLOR variable.   
```
check image : docker ps
docker inspect containerID
```
2. Run a container named blue-app using image kodekloud/simple-webapp and set the environment variable APP_COLOR to blue. Make the application available on port 38282 on the host. The application listens on port 8080.   
```
docker run --name blue-app -e APP_COLOR=blue -p 38282:8080 kodekloud/simple-webapp
```
3. background 확인
4. Deploy a mysql database using the mysql image and name it mysql-db.
Set the database password to use db_pass123. Lookup the mysql image on Docker Hub and identify the correct environment variable to use for setting the root password.
```
docker run --name mysql-db -e MYSQL_ROOT_PASSWORD=db_pass123 mysql
```
