create image:
mvn  install dockerfile:build

get image id:
docker images

run docker container:
docker run -it --rm  --expose 8080 -p 8080:8080 -d <image_id>
("-p  8080:8080 -d" mac only, since does not support host net config, as linux)

get container id:
docker ps

ssh docker container:
docker exec -it <container_id> /bin/bash