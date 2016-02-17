db.posts.aggregate( [
    { $project : { "comments.author": 1 } },
    { $unwind: "$comments" },
    { $group : { _id : "$comments.author", count: {$sum : 1} } },
    { $sort : { count : 1} }
]).forEach(function(x){printjson(x)})

db.zips.aggregate( [
    { $match: { state: { $in: ["CA", "NY"] } } },
    { $group: { _id: { state: "$state", city: "$city" },
                pop: {$sum: "$pop"} } },
    { $match: { pop: {$gt: 25000} } },
    { $group: { _id: null,
                pop: {$avg: "$pop"} } }
] ).forEach(function(x){printjson(x)})

db.zips.aggregate( [
   { $project : {
       first_char: { $substr: [ "$city", 0, 1] },
       pop: 1,
       city: "$city",
       zip: "$_id",
       state: 1
   } },
   { $match : {
       first_char: { $in: [ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'] }
   } },
   {
      "$group" : { _id: null,
                   population: { $sum : "$pop"} }
   }
] ).forEach(function(x){printjson(x)})

