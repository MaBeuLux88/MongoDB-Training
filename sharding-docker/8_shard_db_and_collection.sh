#!/bin/bash
echo -e "\n *** Enabling Sharding ! ***\n"
echo 'sh.enableSharding("test");
      sh.shardCollection("test.testcol", {a:1,b:1} )' | docker exec -i mongos-1 mongosh --quiet

