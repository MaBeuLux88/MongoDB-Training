#!/bin/bash
echo -e "\n *** Starting Mongod! ***\n"
mongod --dbpath data \
       --logpath data/mongod_wiredTiger.log \
       --port 27017 \
       --bind_ip 127.0.0.1 \
       --fork;
