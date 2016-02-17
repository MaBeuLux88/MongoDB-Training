db.tweets.aggregate( [
    { $match: { "user.friends_count": { $gt: 0 },
                "user.followers_count": { $gt: 0 } } },
    { $project: { ratio: {$divide: ["$user.followers_count",
                                    "$user.friends_count"]},
                  screen_name : "$user.screen_name"} },
    { $sort: { ratio: -1 } },
    { $limit: 1 } ] ).forEach(function(x){printjson(x)});


db.tweets.aggregate( [
    { $match: { "user.time_zone": "Brasilia", "user.statuses_count": {$gt: 100} } },
    { $sort : {"user.followers_count": -1} },
    { $project: { screen_name : "$user.screen_name", 
                  tweets: "$user.statuses_count", 
                  nb_followers: "$user.followers_count" } }, 
    { $limit : 1}
    ] ).forEach(function(x){printjson(x)});

db.tweets.aggregate( [
    { "$group" : { "_id" : "$source",
                   "count" : { "$sum" : 1 } } },
    { "$sort" : { "count" : -1 } },
    { "$limit" : 1}
] ).forEach(function(x){printjson(x)});

db.tweets.aggregate( [
   { "$group" : { "_id" : "$user.screen_name",
                  "tweet_texts" : { "$push" : "$text" },
                  "count" : { "$sum" : 1 } } },
   { "$sort" : { "count" : -1 } },
   { "$limit" : 3 }
] ).forEach(function(x){printjson(x)});

