#!/usr/bin/env bash
./1_create_network.sh
./2_start_shard_1.sh
./3_start_shard_2.sh
./4_start_shard_3.sh
./5_start_config_servers.sh
./6_start_mongos.sh
./7_add_all_shards.sh
./8_shard_db_and_collection.sh
#./9_generate_tons_of_datas.sh
#./10_kill_all_and_clean.sh
