#!/bin/bash
echo -e "\n *** Starting Massive Insert Loop ! ***\n"
echo 'for (i=0; i<100; i++) { 
        docArr = []; 
        for (j=0; j<100; j++) { 
          docArr.push( { a : i, b : j, c : "Filler String 000000000000000000000000000000000000000" } )
        };
        db.testcol.insertMany(docArr) 
      }' | docker exec -i mongos-1 mongosh --quiet

