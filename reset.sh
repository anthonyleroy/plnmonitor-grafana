#!/usr/bin/env bash

./clean.sh
echo "deleting persistent storage volumes"
docker volume rm  plnmonitor-grafana_pln_dbdata


