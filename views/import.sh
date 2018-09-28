#!/usr/bin/env bash
mongoimport --drop -d gameofthrones -c characters gameofthrones.characters.json
