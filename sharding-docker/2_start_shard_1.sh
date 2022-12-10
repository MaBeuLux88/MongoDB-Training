#!/usr/bin/env bash
echo -e "\n *** Starting Shard 1 ! ***\n"
docker run --rm -d -p 27118:27018 -h mongod-s1-1 --name mongod-s1-1 --network mongonet mongo:latest --replSet=shard1 --bind_ip_all --shardsvr
docker run --rm -d -p 27128:27018 -h mongod-s1-2 --name mongod-s1-2 --network mongonet mongo:latest --replSet=shard1 --bind_ip_all --shardsvr
docker run --rm -d -p 27138:27018 -h mongod-s1-3 --name mongod-s1-3 --network mongonet mongo:latest --replSet=shard1 --bind_ip_all --shardsvr

sleep 5

echo 'rs.initiate({
      _id: "shard1",
      members: [
         { _id: 0, host: "mongod-s1-1:27018" },
         { _id: 1, host: "mongod-s1-2:27018" },
         { _id: 2, host: "mongod-s1-3:27018" }]});' | docker exec -i mongod-s1-1 mongosh --quiet --port 27018

