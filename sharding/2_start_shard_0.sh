#!/bin/bash
echo -e "\n *** Starting Shard 0 ! ***\n"
mongod --replSet shard0 --shardsvr \
       --dbpath cluster/shard0/m0 \
       --logpath cluster/shard0/m0/mongod.log \
       --fork --port 27107

mongod --replSet shard0 --shardsvr \
       --dbpath cluster/shard0/m1 \
       --logpath cluster/shard0/m1/mongod.log \
       --fork --port 27108

mongod --replSet shard0 --shardsvr \
       --dbpath cluster/shard0/arb \
       --logpath cluster/shard0/arb/mongod.log \
       --fork --port 27109

sleep 1

echo 'rs.initiate({
      _id: "shard0",
      members: [
         { _id: 0, host: "127.0.0.1:27107" },
         { _id: 1, host: "127.0.0.1:27108" },
         { _id: 2, host: "127.0.0.1:27109", arbiterOnly:true }]});' | mongo --port 27107

