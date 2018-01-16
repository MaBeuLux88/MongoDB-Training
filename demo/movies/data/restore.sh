#!/bin/bash
rm -rf dump
unzip movies.zip
mongorestore --drop dump
rm -rf dump
