#!/usr/bin/env bash

#start all plnmonitor services

docker-compose up -d plnmonitordb

docker-compose run plnmondaemon /usr/bin/java -jar /opt/plnmonitor-daemon.jar

docker-compose up -d plnmonwebapp

echo "plnmonitor is now available at : http://localhost:3000/"
