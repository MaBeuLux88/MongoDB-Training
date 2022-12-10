#!/usr/bin/env bash
echo -e "\n *** Starting Shard 2 ! ***\n"
docker run --rm -d -p 27218:27018 -h mongod-s2-1 --name mongod-s2-1 --network mongonet mongo:latest --replSet=shard2 --bind_ip_all --shardsvr
docker run --rm -d -p 27228:27018 -h mongod-s2-2 --name mongod-s2-2 --network mongonet mongo:latest --replSet=shard2 --bind_ip_all --shardsvr
docker run --rm -d -p 27238:27018 -h mongod-s2-3 --name mongod-s2-3 --network mongonet mongo:latest --replSet=shard2 --bind_ip_all --shardsvr

sleep 5

echo 'rs.initiate({
      _id: "shard2",
      members: [
         { _id: 0, host: "mongod-s2-1:27018" },
         { _id: 1, host: "mongod-s2-2:27018" },
         { _id: 2, host: "mongod-s2-3:27018" }]});' | docker exec -i mongod-s2-1 mongosh --quiet --port 27018

