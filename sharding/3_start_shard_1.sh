#!/bin/bash
echo -e "\n *** Starting Shard 1 ! ***\n"
mongod --replSet shard1 --shardsvr \
       --dbpath cluster/shard1/m0 \
       --logpath cluster/shard1/m0/mongod.log \
       --port 27117 \
       --bind_ip 127.0.0.1 \
       --fork

mongod --replSet shard1 --shardsvr \
       --dbpath cluster/shard1/m1 \
       --logpath cluster/shard1/m1/mongod.log \
       --port 27118 \
       --bind_ip 127.0.0.1 \
       --fork

mongod --replSet shard1 --shardsvr \
       --dbpath cluster/shard1/arb \
       --logpath cluster/shard1/arb/mongod.log \
       --port 27119 \
       --bind_ip 127.0.0.1 \
       --fork

sleep 1

echo 'rs.initiate({
      _id: "shard1",
      members: [
         { _id: 0, host: "127.0.0.1:27117" },
         { _id: 1, host: "127.0.0.1:27118" },
         { _id: 2, host: "127.0.0.1:27119", arbiterOnly:true }]});' | mongo --port 27117

