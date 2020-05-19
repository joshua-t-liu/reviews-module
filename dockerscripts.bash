# May 16 Workflow
npm run docker:build
docker exec -it reviews-module_reviews_1 sh
docker exec -it reviews-module_mysql_1 bash
mysql -uroot -pexamplepw
show databases;
use adidas_fec;
select * from Reviews;
quit
exit

# May 15 Workflow Alex Hong
docker pull mysql:5.7
docker run \
--detach \
--name=mysqldb \
--env="MYSQL_ROOT_PASSWORD=examplepw" \
--network="bridge" \
--publish 6603:3306 \
mysql:5.7
docker ps -a
docker exec -it mysqldb bash
# Wait a few seconds for mysql to go from starting -> healthy
mysql -uroot -pexamplepw
# mysql> npm run seed (echo schema.sql > mysql) [copy paste]
show databases;
use adidas_fec;
select * from Reviews;
quit
exit
docker ps
docker commit 848e81c8509a alexzhaohong/mysqlseeded:5.7
docker rm -f mysqldb
docker images
docker run \
--detach \
--name=mysqldb \
--env="MYSQL_ROOT_PASSWORD=examplepw" \
--network="bridge" \
--publish 6603:3306 \
alexzhaohong/mysqlseeded:5.7
docker ps -a
docker exec -it mysqldb bash
mysql -uroot -pexamplepw
# SHOULD ALREADY BE FILLED
show databases;
use adidas_fec;
select * from Reviews;
quit
exit
docker network ls
docker network inspect bridge
# ADJUST localhost -> 172.17.0.3
docker build -t alexzhaohong/reviewsimg .
docker run -d -p 3003:3003 --rm --name reviewscont alexzhaohong/reviewsimg
open http://localhost:3003
# CELEBRATE the connection
docker login
docker push alexzhaohong/mysqlseeded:5.7
docker push alexzhaohong/reviewsimg:latest
docker ps -a
docker rm -f reviewscont mysqldb
docker images
docker rmi alexzhaohong/reviewsimg alexzhaohong/mysqlseeded:5.7
docker rmi mysql5.7-seeded
docker pull alexzhaohong/mysqlseeded:5.7
docker run \
--detach \
--name=mysqldb \
--env="MYSQL_ROOT_PASSWORD=examplepw" \
--network="bridge" \
--publish 6603:3306 \
alexzhaohong/mysqlseeded:5.7
docker exec -it mysqldb bash
mysql -uroot -pexamplepw
# SHOULD ALREADY BE FILLED
show databases;
use adidas_fec;
show tables;
select * from Reviews;
# REVIEWS TABLE NOT FOUND
quit
exit
docker network ls
docker network inspect bridge
# IPv4 changed... 172.17.0.3 != 172.17.0.2
docker pull alexzhaohong/reviewsimg
docker run -d -p 3003:3003 --rm --name reviewscont alexzhaohong/reviewsimg
docker exec -it reviewscont sh

open http://localhost:3003
# ERRORS: No Rows in Tables, Wrong IPv4

# Compose Workflow
docker-compose up -d --build
open http://localhost:3003
docker ps -a
docker volume ls
containername="reviews-module_reviews-module_1"
echo $containername
docker logs $containername
docker exec -it $containername sh
docker-compose down -v --rmi all

# Workflow
docker build
docker images 
docker run
open http://localhost:3003
docker ps
docker stop 
docker rm
docker rmi 
# Publishing
docker build -t alexzhaohong/reviewsfecserver .
docker login
docker image push <YourDockerID>/firstimage
docker push alexzhaohong/reviewsfecserver:tagname
docker pull alexzhaohong/reviewsfecserver:latest
docker run -d -p 3003:3003 --name reviewscontainer alexzhaohong/reviewsfecserver
open http://localhost:3003
docker logs reviewscontainer
docker exec -it reviewscontainer sh
docker rm -f reviewscontainer
docker rmi alexzhaohong/reviewsfecserver:latest
# 6
docker-compose up -d
docker-compose up -d --build
docker-compose down -v --rmi all
# 5-Make_Multiple_Containers_Work_Together
docker network ls
docker network inspect <network-name> #IPv4 Addressing
# 4-Containerized_Development_With_Volumes
docker logs <container-name>
docker volume ls
docker volume prune
# 3-Bundle_Your_App_Into_An_Image
docker pull <image-name> : <version>
docker history <image-name>
docker build --tag <image-name> .
docker run -d -p <hostport:containerport> -v <$(pwd):directorypath> --rm --network=<network-name> --name <container-name> <image-name>
docker restart <container-name>
# 2-Long_Lived_Containers
docker stop <container-name>
docker start <container-name>
docker rm -f <container-name>
docker rmi <image-name>
# 1-Introduction
docker info
docker images -a
docker run <image-name>
docker ps
docker ps -a







# https://phoenixnap.com/kb/mysql-docker-container
docker pull mysql/mysql-server:5.7
docker images
docker run --name=mysqldb -d mysql/mysql-server:5.7
docker ps -a
docker logs mysqldb
usocikJixOHupd4kk0jawUPOgONN
docker exec -it mysqldb mysql -uroot -pexamplepw
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'examplepw';



docker run \
--detach \
--name=mysqldb2 \
--env="MYSQL_ROOT_PASSWORD=examplepw MYSQL_DATABASE=adidas_fec" \
--publish 6603:3306 \
--volume=$(pwd)/db-mysql/storage/docker/mysql-data:/var/lib/mysql \
mysql/mysql-server:5.7

docker ps -a
open http://localhost:6603
docker logs mysqldb
docker exec -it mysqldb2 mysql -uroot -pexamplepw
docker exec -it mysqldb bash
cd /etc/conf.d
cd /var/lib/mysql
docker exec mysqldb npm run seed
docker inspect mysqldb



mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
mkdir -p /storage/docker/mysql-data

docker ps -a
docker rm -f mysqldb
docker rmi mysql alexzhaohong/reviewsfecserver 
