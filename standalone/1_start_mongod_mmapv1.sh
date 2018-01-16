#!/bin/bash
echo -e "\n *** Starting Mongod MMAPV1 ! ***\n"
mongod --storageEngine mmapv1 \
       --dbpath data-mmapv1 \
       --logpath log/mongod_mmapv1.log \
       --port 27018 \
       --bind_ip 127.0.0.1 \
       --fork;
