#!/bin/bash
echo -e "\n *** Starting Replica Set ! ***\n"
mongod --replSet replicaTest \
       --dbpath replicaTest/m0 \
       --logpath replicaTest/m0/mongod.log \
       --port 27017 \
       --bind_ip 127.0.0.1 \
       --fork

mongod --replSet replicaTest \
       --dbpath replicaTest/m1 \
       --logpath replicaTest/m1/mongod.log \
       --port 27018 \
       --bind_ip 127.0.0.1 \
       --fork

mongod --replSet replicaTest \
       --dbpath replicaTest/arb \
       --logpath replicaTest/arb/mongod.log \
       --port 27019 \
       --bind_ip 127.0.0.1 \
       --fork

sleep 1

echo 'rs.initiate({
      _id: "replicaTest",
      members: [
         { _id: 0, host: "127.0.0.1:27017" },
         { _id: 1, host: "127.0.0.1:27018" },
         { _id: 2, host: "127.0.0.1:27019", arbiterOnly:true }]});' | mongo

