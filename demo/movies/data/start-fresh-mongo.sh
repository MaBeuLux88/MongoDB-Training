#!/bin/bash
./clean.sh
mkdir database
mongod --dbpath database --logpath mongod.log --bind_ip 127.0.0.1 --fork
./restore.sh
