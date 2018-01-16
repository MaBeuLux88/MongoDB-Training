// Indexes

db.movies.getIndexes()

// simple
db.movies.find({"year" : 1999}).explain() // "queryPlanner" "executionStats" "allPlansExecution"
db.movies.createIndex({"year" : 1})
db.movies.find({"year" : 1999}).explain(true)
db.movies.dropIndex("year_1")

db.movies.createIndex({"year" : 1}, {name:"Robert"})
db.movies.dropIndex("Robert")

// background
db.movies.createIndex({"year" : 1}, {name:"Robert", background:true})
db.movies.dropIndex("Robert")

// unique
db.movies.count()
db.movies.distinct("title")
db.movies.distinct("title").length
db.movies.createIndex({"year" : 1}, {name:"Robert", unique:true})
db.movies.createIndex({"title" : 1}, {name:"Robert", unique:true})
db.movies.find().hint("Robert").length()

// sparse
db.movies.update({_id:1},{$set:{comment : "Ce film est pourri."}})
db.movies.find({comment:{$exists:true}})
db.movies.createIndex({"comment" : 1}, {name:"Bob", sparse: true})
db.movies.find().hint("Bob").length()

// composé
db.movies.createIndex({"country": 1, "year" : 1}, {name:"Compose"})
db.movies.find({"country":"USA", "year":1990}, {title: 1, year:1, genre:1}).sort({"genre":1})

// index scan + fetch + sort + projection
db.movies.find({"country":"USA", "year":1990}, {title: 1, year:1, genre:1}).sort({"genre":1}).explain(true)

// double index scan + sort_merge + fetch + projection
db.movies.find({"country":{$in:["USA","FR"]}, "year":{$gte:1990}}, {title: 1, year:1, genre:1}).sort({"year":1}).explain(true)

// index scan + fetch + projection
db.movies.find({"country":"USA", "year":1990}, {title:1,year:1,genre:1}).sort({"year":1}).explain()

// index scan + project => COVERED QUERY
db.movies.find({"country":"USA", "year":1990}, {_id:0,country:1,year:1}).sort({"year":1}).explain()
db.movies.dropIndex("Compose")

// multikey
db.movies.createIndex({"actors":1})
db.movies.createIndex({"actors.firstname":-1})

// hashed
db.movies.createIndex({"year":"hashed"})

// partial
db.movies.createIndex({"title":1}, {"name":"partial", partialFilterExpression: { imdb: { $gt: 5 } }})
db.movies.find().hint("partial").length() // 32
// equality expressions (i.e. field: value or using the $eq operator),
// $exists: true expression,
// $gt, $gte, $lt, $lte expressions,
// $type expressions,
// $and operator at the top-level only

// TTL
// Champ ISODATE
db.eventlog.createIndex( { "lastModifiedDate": 1 }, { expireAfterSeconds: 3600 } )

// Text
db.movies.createIndex({title: "text", summary:"text"}, {weights: {title:5}, name: "TextIndex"})
db.movies.getIndexes()
db.movies.find({$text: {$search:"tueur fou dollars"}},{score:{$meta:"textScore"}, actors:0, director:0}).sort({score:{$meta:"textScore"}}).pretty()


// geo 2d
loc : [ <longitude> , <latitude> ]
loc : { lng : <longitude> , lat : <latitude> }

db.collection.createIndex( { loc : "2d" } , { min : <lower bound> , max : <upper bound> } )

db.places.find( { loc :
                  { $geoWithin :
                     { $box : [ [ 0 , 0 ] ,
                                [ 100 , 100 ] ]
                 } } } )

db.places.find( { loc: { $geoWithin :
                          { $center : [ [-74, 40.74 ] , 10 ]
                } } } )

// geo 2dsphere
db.collection.createIndex( { <location field> : "2dsphere" } )

db.restaurants.find({ location:
   { $geoWithin:
      { $centerSphere: [ [ -73.93414657, 40.82302903 ], 5 / 3963.2 ] } } })

var METERS_PER_MILE = 1609.34
db.restaurants.find({ location: { $nearSphere: { $geometry: { type: "Point", coordinates: [ -73.93414657, 40.82302903 ] }, $maxDistance: 5 * METERS_PER_MILE } } })

