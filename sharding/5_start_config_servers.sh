#!/bin/bash
echo -e "\n *** Starting Config Servers ! ***\n"
mongod --replSet configSvr --configsvr \
       --dbpath cluster/config/c0 \
       --logpath cluster/config/c0/mongod.log \
       --fork --port 27217

mongod --replSet configSvr --configsvr \
       --dbpath cluster/config/c1 \
       --logpath cluster/config/c1/mongod.log \
       --fork --port 27218

mongod --replSet configSvr --configsvr \
       --dbpath cluster/config/c2 \
       --logpath cluster/config/c2/mongod.log \
       --fork --port 27219

sleep 1

echo 'rs.initiate({
      _id: "configSvr",
      configsvr : true,
      members: [
         { _id: 0, host: "127.0.0.1:27217" },
         { _id: 1, host: "127.0.0.1:27218" },
         { _id: 2, host: "127.0.0.1:27219" }]});' | mongo --port 27217
