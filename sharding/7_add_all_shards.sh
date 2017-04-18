#!/bin/bash
echo -e "\n *** Adding Shards to cluster ! ***\n"
echo 'sh.addShard("shard0/127.0.0.1:27107");
      sh.addShard("shard1/127.0.0.1:27117");
      sh.addShard("shard2/127.0.0.1:27127");
      sh.status()' | mongo
