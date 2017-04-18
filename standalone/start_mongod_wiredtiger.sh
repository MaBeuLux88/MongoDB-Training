#!/bin/bash
echo -e "\n *** Starting Mongod WiredTiger ! ***\n"
mongod --dbpath data-wiredtiger \
       --logpath log/mongod_wiredTiger.log \
       --port 27017 \
       --fork;
