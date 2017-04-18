#!/bin/bash
echo -e "\n *** Enabling Sharding ! ***\n"
echo 'sh.enableSharding("test");
      sh.shardCollection("test.testcol", {a:1,b:1} )' | mongo
