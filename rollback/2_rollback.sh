#!/usr/bin/env bash
# Writing one data to the entire cluster
echo -e "\nWritting a message to the primary (mongo1) & secondary (mongo2)"
docker run -t --rm --network netmongo mongo:4.2.0 mongo --host replicaTest/mongo1:27017,mongo2:27017 --quiet --eval 'db.hello.insert({"_id": 1, "msg": "This document will be written on the primary and replicated on the secondary."})' | grep -v NETWORK

# Stopping mongo2
echo -e "\nStopping the secondary (mongo2)"
docker stop mongo2

# Writting only to mongo1
echo -e "\nWritting a message to the primary (mongo1)"
docker run -t --rm --network netmongo mongo:4.2.0 mongo --host replicaTest/mongo1:27017,mongo2:27017 --quiet --eval 'db.hello.insert({"_id": 2, "msg": "This document will be written ONLY on the primary. It will be rollbacked."})' | grep -v NETWORK

# Show current content of the collection
echo -e "\nContent of the collection:"
docker run -t --rm --network netmongo mongo:4.2.0 mongo --host replicaTest/mongo1:27017,mongo2:27017 --quiet --eval 'db.hello.find()' | grep -v NETWORK

# Stopping mongo1 
echo -e "\nStopping the primary (mongo1)"
docker stop mongo1

# Start mongo2
echo -e "\nRestarting the secondary (mongo2) -> will become primary"
docker start mongo2
echo -e "\nSleep 10 sec... waiting for election."
sleep 10

# Write on new primary
echo -e "\nNow that we have a new primary, we can write again."
docker run -t --rm --network netmongo mongo:4.2.0 mongo --host replicaTest/mongo1:27017,mongo2:27017 --quiet --eval 'db.hello.insert({"_id": 3, "msg": "This document will be written on the new primary and replicated when the secondary comes back up."})' | grep -v NETWORK

# Show current content of the collection
echo -e "\nContent of the collection:"
docker run -t --rm --network netmongo mongo:4.2.0 mongo --host replicaTest/mongo1:27017,mongo2:27017 --quiet --eval 'db.hello.find()' | grep -v NETWORK

# Start mongo1
echo -e "\nRestarting mongo1. Joining as a secondary and realising he has to rollback one document."
docker start mongo1

# ROLLBACK on mongo1
echo -e "\n### ROLLBACK on mongo1 ###"
sleep 10

# Show current content of the collection
echo -e "\nContent of the collection before restoration:"
docker run -t --rm --network netmongo mongo:4.2.0 mongo --host replicaTest/mongo1:27017,mongo2:27017 --quiet --eval 'db.hello.find()' | grep -v NETWORK

# Show rollback folder in the m1 folder and its content
echo -e "\nRollback folder content: replicaTest/m1/rollback/test.hello"
ls -l replicaTest/m1/rollback/test.hello
rollbackFile=$(ls replicaTest/m1/rollback/test.hello)

# Restoring the missing document in the collection hello
echo -e "\nRestoring the document in the collection hello"
docker exec -it mongo1 mongorestore --host replicaTest/mongo1:27017,mongo2:27017 -d test -c hello /data/db/rollback/test.hello/$rollbackFile

# Content of the collection after restoration
echo -e "\nContent of the collection after restoration:"
docker run -t --rm --network netmongo mongo:4.2.0 mongo --host replicaTest/mongo1:27017,mongo2:27017 --quiet --eval 'db.hello.find()' | grep -v NETWORK
