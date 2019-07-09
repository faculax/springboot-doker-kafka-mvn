#FROM openjdk:8-jdk-alpine
FROM ubuntu:18.04

#Install Open JDK 8
RUN apt-get update \
    && apt-get -y install openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

ENV DEBIAN_FRONTEND noninteractive
ENV SCALA_VERSION 2.12
ENV KAFKA_VERSION 2.2.0
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"

# Install Kafka, Zookeeper and other needed things
RUN apt-get update && \
    apt-get install -y zookeeper wget supervisor dnsutils && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    wget http://apache.mirror.anlx.net/kafka/2.2.0/kafka_2.12-2.2.0.tgz && \
    mv kafka_2.12-2.2.0.tgz /tmp && \
    tar -xzf tmp/kafka_2.12-2.2.0.tgz -C /tmp/ && \
    cp -r /tmp/kafka_2.12-2.2.0/ /opt/ && \
    rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz

# Install telnet so we can healthcheck zookeeper
RUN apt-get update && \
    apt-get -y install telnet

# 2181 is zookeeper, 9092 is kafka
EXPOSE 2181 9092


VOLUME /tmp
ARG DEPENDENCY=target/dependency
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app
COPY /target/gs-spring-boot-docker-0.1.0.jar /app


CMD tail -f /dev/null