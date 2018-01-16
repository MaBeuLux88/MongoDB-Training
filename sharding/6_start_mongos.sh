#!/bin/bash
echo -e "\n *** Starting 2 Mongos ! ***\n"
mongos --logpath cluster/s0/mongos.log \
       --bind_ip 127.0.0.1 \
       --port 27017 \
       --configdb configSvr/127.0.0.1:27217,127.0.0.1:27218,127.0.0.1:27219 \
       --fork

mongos --logpath cluster/s1/mongos.log \
       --bind_ip 127.0.0.1 \
       --port 27018 \
       --configdb configSvr/127.0.0.1:27217,127.0.0.1:27218,127.0.0.1:27219 \
       --fork
