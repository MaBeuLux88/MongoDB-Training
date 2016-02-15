#!/bin/bash
echo -e "\n *** Starting Mongod WiredTiger ! ***\n"
mongod --smallfiles \
       --dbpath data-wiredtiger \
       --logpath log/mongod_wiredTiger.log \
       --fork \
       --port 27017;
