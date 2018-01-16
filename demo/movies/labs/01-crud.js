// Javascript inside
i = 3
j = 4
i+j
for (i=0;i<10;i++) { print(i) }

// helpers : 
db
show dbs
use local
show collections

// Hello World
use myDatabase; 
db.myCollection.insert({ "Hello":"World!"}); 
db.myCollection.find(); 
db.myCollection.remove({}); // WARNING - Delete ALL documents!
db.myCollection.drop();
db.dropDatabase();

// Charger des données.
cd data
unzip movies.zip
mongorestore 

// CRUD 
mongo tp 
db.movies.findOne() 
db.movies.count()
db.movies.find() // it + it + it...
db.movies.find({}).pretty() 
db.movies.find({"year" : 1958}) 
db.movies.find({"year" : 1958, "country" : "USA"}) 
db.movies.find({"year" : { $gt : 1970 }}) 
db.movies.find({"year" : { $gte : 1970 }}) 
db.movies.find({"year" : { $lt : 1970 }}) 
db.movies.find({"year" : { $lte : 1970 }}) 
db.movies.find({"year" : { $ne : 1970 }}) 
db.movies.find({"year" : { $in : [1958,1959]}}) 
db.movies.find({"year" : { $nin : [1958,1959]}}) 
db.movies.find({$or: [{"year" : 1958},{"year" : 1959}]}) 

db.movies.find({"_id":1},{"actors":1}) // actors + _id 
db.movies.find({"_id":1},{"actors":0, "summary": 0})

db.movies.findOne({"director.last_name": "Scott"})

db.movies.count({ "director.first_name" : { $exists : true } } ) 
db.movies.count({ "actors.1.first_name" : "Robert" } ) 
db.movies.count({ "actors.1.first_name" : { $exists : true } } ) 

db.movies.count({ "year" : {$type:1}}) // format "Double" -> https://docs.mongodb.com/manual/reference/operator/query/type/#op._S_type

// BULK INSERT
db.arrays.insert([
{"_id":1,"tab":[1,2,3,4,5]},
{"_id":2,"tab":[7,5,6,2,4]},
{"_id":3,"tab":[9,4,3,4,8]},
{"_id":2,"tab":[3,2,5,6,2]},
{"_id":4,"tab":[2,3,0,0,1]}
])

db.arrays.insert([
{"_id":1,"tab":[1,2,3,4,5]},
{"_id":2,"tab":[7,5,6,2,4]},
{"_id":3,"tab":[9,4,3,4,8]},
{"_id":2,"tab":[3,2,5,6,2]},
{"_id":4,"tab":[2,3,0,0,1]}
], {ordered : false})

db.arrays.find({"tab": { $all : [1,2] }})
db.arrays.find({"tab": { $in : [1,2] }})
db.arrays.find({"tab.2":3})

db.movies.find({"actors.last_name":"Voight", "actors.birth_date":"1948"}, {actors:1}).pretty()
db.movies.find({actors:{$elemMatch:{"last_name":"Voight", "birth_date":"1948"}}}, {actors:1}).pretty()

// SORT / SKIP / LIMIT
db.movies.find({},{title:1,year:1})
db.movies.find({},{title:1,year:1}).sort({"year":1})
db.movies.find({},{title:1,year:1}).sort({"year":1}).skip(10)
db.movies.find({},{title:1,year:1}).sort({"year":1}).skip(10).limit(3)

// UPDATE => https://docs.mongodb.com/manual/reference/operator/update/
db.movies.update({"_id":1},{"year":2016}) // WARNING!
db.movies.update({"_id":1},{ $set : {"year":2016}}) 
db.movies.update({"_id":1},{ $unset : {"year":1}}) 
db.movies.update({"_id":1},{ $rename: {"year":"date"} })

db.movies.update({"year" : 1999},{ $set : { "decade" : "90's"}}) 
db.movies.update({"year" : 1999},{ $set : { "decade" : "90's"}},{"multi":true}) 
db.movies.find({"year" : 1999},{_id:0,title:1,year:1,decade:1}).pretty()

// inc
db.movies.update({"imdb" : {$lt:7}}, { $inc : {"imdb" : 2} }, { "multi" : true})

// min + max
db.movies.update({"_id":1}, {$min: {"imdb":5}} )
db.movies.update({"_id":1}, {$max: {"imdb":8}} )

// push + pull
db.movies.update( {"_id":1},{ $push : { "some_array" : 1 } }) 
db.movies.findOne({"_id":1},{ "some_array":1 }) 
db.movies.update( {"_id":1},{ $pull : { "some_array" : 1 } })

// addToSet
db.movies.update( {"_id":1},{ $addToSet : { "some_array" : 2 } })
db.movies.findOne({"_id":1},{ "some_array":1 })

// pop
db.movies.update( {"_id":1},{ $pop : { "some_array" : 1 } })
db.movies.update( {"_id":1},{ $pop : { "some_array" : -1 } })

// pushAll + pullAll
db.arrays.update({},{ $pushAll : { "tab" : [ 3, 4, 5 ] } }, {multi:true})
db.arrays.update({},{ $pullAll : { "tab" : [ 3, 4, 5 ] } }, {multi:true})

