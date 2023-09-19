#!/usr/bin/env bash

# Configuration of plnmonitor

# create external network
docker network create web

# start plnmonitor database
docker-compose up --force-recreate  --build -d  plnmonitordb 

# get container name assigned by docker-compose
plnmonitor_container_name=`docker-compose ps plnmonitordb | tail -n +3 | awk '{ print $1 }'`;

until docker exec "${plnmonitor_container_name}" pg_isready -U plnmonitor; do
  echo >&2 " Please wait for database to start... (this can take up to one minute)"
  sleep 10
done
echo "Database is now ready !"

# run configuration of the daemon
docker-compose build plnmondaemon 
docker-compose run plnmondaemon /usr/bin/java -Xmx1024m -jar /opt/plnmonitor-daemon.jar config

#create grafana user
#docker exec -u postgres plnmonitor-grafana_plnmonitordb_1 psql -U plnmonitor -c " CREATE USER grafana WITH PASSWORD 'grafana';  GRANT CONNECT ON DATABASE plnmonitor TO grafana; GRANT SELECT ON ALL TABLES IN SCHEMA plnmonitor TO grafana; ALTER DEFAULT PRIVILEGES IN SCHEMA plnmonitor GRANT SELECT ON TABLES TO grafana;"

docker-compose down
