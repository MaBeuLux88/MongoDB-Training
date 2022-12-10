#!/bin/bash
echo -e "\n *** Adding Shards to cluster ! ***\n"
echo 'sh.addShard("shard1/mongod-s1-1:27018");
      sh.addShard("shard2/mongod-s2-1:27018");
      sh.addShard("shard3/mongod-s3-1:27018");
      sh.status()' | docker exec -i mongos-1 mongosh --quiet

