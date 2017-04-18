#!/bin/bash
echo -e "\n *** Starting Shard 2 ! ***\n"
mongod --replSet shard2 --shardsvr \
       --dbpath cluster/shard2/m0 \
       --logpath cluster/shard2/m0/mongod.log \
       --fork --port 27127

mongod --replSet shard2 --shardsvr \
       --dbpath cluster/shard2/m1 \
       --logpath cluster/shard2/m1/mongod.log \
       --fork --port 27128

mongod --replSet shard2 --shardsvr \
       --dbpath cluster/shard2/arb \
       --logpath cluster/shard2/arb/mongod.log \
       --fork --port 27129

sleep 1

echo 'rs.initiate({
      _id: "shard2",
      members: [
         { _id: 0, host: "127.0.0.1:27127" },
         { _id: 1, host: "127.0.0.1:27128" },
         { _id: 2, host: "127.0.0.1:27129", arbiterOnly:true }]});' | mongo --port 27127

