#!/usr/bin/env bash
echo -e "\n *** Starting Config Servers ! ***\n"
docker run --rm -d -p 27419:27019 -h mongod-config-1 --name mongod-config-1 --network mongonet mongo:latest --replSet=configSvr --bind_ip_all --configsvr
docker run --rm -d -p 27429:27019 -h mongod-config-2 --name mongod-config-2 --network mongonet mongo:latest --replSet=configSvr --bind_ip_all --configsvr
docker run --rm -d -p 27439:27019 -h mongod-config-3 --name mongod-config-3 --network mongonet mongo:latest --replSet=configSvr --bind_ip_all --configsvr

sleep 5

echo 'rs.initiate({
      _id: "configSvr",
      configsvr : true,
      members: [
         { _id: 0, host: "mongod-config-1:27019" },
         { _id: 1, host: "mongod-config-2:27019" },
         { _id: 2, host: "mongod-config-3:27019" }]});' | docker exec -i mongod-config-1 mongosh --quiet --port 27019

