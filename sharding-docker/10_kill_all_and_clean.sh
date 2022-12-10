#!/bin/bash
echo -e "\n *** Cleaning EVERYTHING ! ***\n"
docker stop $(docker ps -q)
docker network rm mongonet

