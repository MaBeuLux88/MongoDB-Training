#!/usr/bin/env bash
echo '
cursor = db.users.watch([],{"fullDocument":"updateLookup"});

while (!cursor.isExhausted()) {
  if (cursor.hasNext()) {
    print(tojson(cursor.next()));
  }
}' | mongo
