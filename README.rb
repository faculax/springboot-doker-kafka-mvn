create image:
mvn  install dockerfile:build

get image id:
docker images

run docker container:
docker run -it --rm  --expose 8080 -p 8080:8080 -d <image_id>
("-p  8080:8080 -d" mac only, since does not support host net config, as linux)
  --mount type=bind,source="$(pwd)"/target,target=/app       /

get container id:
docker ps

ssh docker container:
docker exec -it <container_id> /bin/bash

start zookeeper:
  "/opt/kafka_2.12-2.2.0/bin/zookeeper-server-start.sh /opt/kafka_2.12-2.2.0/config/zookeeper.properties"

start kafka:
"/opt/kafka_2.12-2.2.0/bin/kafka-server-start.sh /opt/kafka_2.12-2.2.0/config/server.properties"

start spring boot app:
"java -jar gs-spring-boot-docker-0.1.0.jar"

create messages:
localhost:8080/{message}

consume messages:
/opt/kafka_2.12-2.2.0/bin sh kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mytopic --from-beginning