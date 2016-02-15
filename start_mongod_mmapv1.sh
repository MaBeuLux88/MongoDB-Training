#!/bin/bash
echo -e "\n *** Starting Mongod MMAPV1 ! ***\n"
mongod --storageEngine mmapv1 \
       --dbpath data-mmapv1 \
       --logpath log/mongod_mmapv1.log \
       --fork \
       --port 27017;
