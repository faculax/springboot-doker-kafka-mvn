create image:
mvn  install dockerfile:build

get image id:
docker images

run docker container:
docker run -it --rm  --expose 8080 <imgage_id> /bin/ash

ssh docker container:
docker exec -it  <container_id> /bin/ash