#!/bin/bash
mongodump -d tp -c movies
rm -f movies.zip
zip -r movies.zip dump
