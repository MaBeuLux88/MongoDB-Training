#!/bin/bash
# Author : Maxime BEUGNET <maxime.beugnet@gmail.com>
mongoimport --quiet -d mug -c persons persons.1000.json
