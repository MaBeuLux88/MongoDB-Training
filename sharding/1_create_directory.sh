#!/bin/bash
echo -e "\n *** Create folders ! ***\n"
mkdir -p cluster/config/{c0,c1,c2}
mkdir -p cluster/shard0/{m0,m1,arb}
mkdir -p cluster/shard1/{m0,m1,arb}
mkdir -p cluster/shard2/{m0,m1,arb}
mkdir -p cluster/{s0,s1}
