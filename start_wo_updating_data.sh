#!/usr/bin/env bash

#start all plnmonitor services

docker-compose up -d plnmonitordb

docker-compose up -d plnmonwebapp

cp -f ./template/home.json ./provisioning/dashboards/home.json
echo "plnmonitor is now available at : http://localhost:3000/"

docker-compose up -d plnmonloki
