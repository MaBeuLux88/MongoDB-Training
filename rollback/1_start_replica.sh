#!/bin/bash
echo -e "\n *** Create folders ! ***\n"
mkdir -p replicaTest/{m1,m2,arb}

echo -e "\n *** Starting Replica Set ! ***\n"
docker network create netmongo
docker run -d -p 27017:27017 -u 1000:1000 -v $(pwd)/replicaTest/m1:/data/db --network netmongo --network-alias mongo1 --name mongo1 mongo:4.2.0 --replSet replicaTest
docker run -d -p 27018:27017 -u 1000:1000 -v $(pwd)/replicaTest/m2:/data/db --network netmongo --network-alias mongo2 --name mongo2 mongo:4.2.0 --replSet replicaTest
docker run -d -p 27019:27017 -u 1000:1000 -v $(pwd)/replicaTest/arb:/data/db --network netmongo --network-alias mongo3 --name mongo3 mongo:4.2.0 --replSet replicaTest

sleep 4

echo 'rs.initiate({
      _id: "replicaTest",
      members: [
         { _id: 0, host: "mongo1:27017", priority: 2 },
         { _id: 1, host: "mongo2:27017" },
         { _id: 2, host: "mongo3:27017", arbiterOnly:true }]});' | mongo

