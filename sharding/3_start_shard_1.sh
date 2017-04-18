#!/bin/bash
echo -e "\n *** Starting Shard 1 ! ***\n"
mongod --replSet shard1 --shardsvr \
       --dbpath cluster/shard1/m0 \
       --logpath cluster/shard1/m0/mongod.log \
       --fork --port 27117

mongod --replSet shard1 --shardsvr \
       --dbpath cluster/shard1/m1 \
       --logpath cluster/shard1/m1/mongod.log \
       --fork --port 27118

mongod --replSet shard1 --shardsvr \
       --dbpath cluster/shard1/arb \
       --logpath cluster/shard1/arb/mongod.log \
       --fork --port 27119

sleep 1

echo 'rs.initiate({
      _id: "shard1",
      members: [
         { _id: 0, host: "127.0.0.1:27117" },
         { _id: 1, host: "127.0.0.1:27118" },
         { _id: 2, host: "127.0.0.1:27119", arbiterOnly:true }]});' | mongo --port 27117

