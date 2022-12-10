#!/usr/bin/env bash
echo -e "\n *** Starting 2 Mongos ! ***\n"
docker run --rm -d -p 27017:27017 -h mongos-1 --name mongos-1 --network mongonet mongo:latest mongos --configdb configSvr/mongod-config-1:27019,mongod-config-2:27019,mongod-config-3:27019 --bind_ip_all
docker run --rm -d -p 27018:27017 -h mongos-2 --name mongos-2 --network mongonet mongo:latest mongos --configdb configSvr/mongod-config-1:27019,mongod-config-2:27019,mongod-config-3:27019 --bind_ip_all

sleep 5

