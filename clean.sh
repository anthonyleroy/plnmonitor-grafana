#!/usr/bin/env bash

docker-compose down

echo "Removing dashboards"
rm -f ./provisioning/dashboards/*.json
rm -f ./provisioning/dashboards/boxes/*.json 
rm -f ./provisioning/dashboards/tdb_publishers/*.json 
