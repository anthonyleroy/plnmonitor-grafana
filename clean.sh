#!/usr/bin/env bash

docker-compose down
echo "Removing database persistent storage"
rm -rf ./pln_dbdata/*
echo "Removing dashboards"
rm -rf ./provisioning/dashboards/plnmonitor/*.json
