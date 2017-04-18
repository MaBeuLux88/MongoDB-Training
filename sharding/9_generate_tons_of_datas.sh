#!/bin/bash
echo -e "\n *** Starting Massive Insert Loop ! ***\n"
echo 'for (i=0; i<10000; i++) { 
        docArr = []; 
        for (j=0; j<1000; j++) { 
          docArr.push( { a : i, b : j, c : "Filler String 000000000000000000000000000000000000000" } )
        };
        db.testcol.insert(docArr) 
      }' | mongo
