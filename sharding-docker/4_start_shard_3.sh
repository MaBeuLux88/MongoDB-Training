#!/usr/bin/env bash
echo -e "\n *** Starting Shard 3 ! ***\n"
docker run --rm -d -p 27318:27018 -h mongod-s3-1 --name mongod-s3-1 --network mongonet mongo:latest --replSet=shard3 --bind_ip_all --shardsvr
docker run --rm -d -p 27328:27018 -h mongod-s3-2 --name mongod-s3-2 --network mongonet mongo:latest --replSet=shard3 --bind_ip_all --shardsvr
docker run --rm -d -p 27338:27018 -h mongod-s3-3 --name mongod-s3-3 --network mongonet mongo:latest --replSet=shard3 --bind_ip_all --shardsvr

sleep 5

echo 'rs.initiate({
      _id: "shard3",
      members: [
         { _id: 0, host: "mongod-s3-1:27018" },
         { _id: 1, host: "mongod-s3-2:27018" },
         { _id: 2, host: "mongod-s3-3:27018" }]});' | docker exec -i mongod-s3-1 mongosh --quiet --port 27018

