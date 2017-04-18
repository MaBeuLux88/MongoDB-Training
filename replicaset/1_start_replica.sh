#!/bin/bash
echo -e "\n *** Starting Replica Set ! ***\n"
mongod --replSet replicaTest \
       --dbpath replicaTest/m0 \
       --logpath replicaTest/m0/mongod.log \
       --fork --port 27017

mongod --replSet replicaTest \
       --dbpath replicaTest/m1 \
       --logpath replicaTest/m1/mongod.log \
       --fork --port 27018

mongod --replSet replicaTest \
       --dbpath replicaTest/arb \
       --logpath replicaTest/arb/mongod.log \
       --fork --port 27019

sleep 1

echo 'rs.initiate({
      _id: "replicaTest",
      members: [
         { _id: 0, host: "127.0.0.1:27017" },
         { _id: 1, host: "127.0.0.1:27018" },
         { _id: 2, host: "127.0.0.1:27019", arbiterOnly:true }]});' | mongo

