#!/usr/bin/env bash
echo 'db.createView(
        "charactersNoSpoil", 
        "characters", 
        [{ 
           "$project" : 
             { 
               _id : 0,
               "firstName" : 1, 
               "lastName" : 1, 
               "house" : 1, 
               "status" : 
                 {"$cond": [{ "$eq": [ "$status", undefined ] }, $status = "Not Specified", $status = "*****" ]}
              }
        }])' | mongo gameofthrones --quiet

echo 'db.charactersNoSpoil.find({},{firstName:1, status:1})' | mongo gameofthrones --quiet
