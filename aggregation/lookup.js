db.rental.drop()
db.reading.drop()

db.rental.insertMany([
{
	"_id" : ObjectId("5b475843608f74d0e8bf073a"),
	"deviceId" : 1,
	"start_date" : ISODate("2018-05-10T10:11:23.143Z"),
	"end_date" : ISODate("2018-07-11T12:19:53.143Z")
},
{
	"_id" : ObjectId("5b475843608f74d0e8bf073b"),
	"deviceId" : 2,
	"start_date" : ISODate("2018-03-09T10:11:23.143Z"),
	"end_date" : ISODate("2018-03-10T12:19:53.143Z")
},
{
	"_id" : ObjectId("5b475843608f74d0e8bf073c"),
	"deviceId" : 2,
	"start_date" : ISODate("2018-03-11T10:11:23.143Z"),
	"end_date" : ISODate("2018-05-12T12:19:53.143Z")
},
{
	"_id" : ObjectId("5b475843608f74d0e8bf073d"),
	"deviceId" : 3,
	"start_date" : ISODate("2018-01-10T10:11:23.143Z"),
	"end_date" : ISODate("2018-09-11T12:19:53.143Z")
}
])

db.reading.insertMany([
{
	"_id" : ObjectId("5b47578f608f74d0e8bf0735"),
	"deviceId" : 1,
	"timestamp" : ISODate("2018-05-11T10:11:23.143Z"),
	"data" : "wathever 1"
},
{
	"_id" : ObjectId("5b47578f608f74d0e8bf0736"),
	"deviceId" : 2,
	"timestamp" : ISODate("2018-03-10T00:00:00Z"),
	"data" : "wathever 2-1"
},
{
	"_id" : ObjectId("5b47578f608f74d0e8bf0737"),
	"deviceId" : 2,
	"timestamp" : ISODate("2018-03-09T23:00:00Z"),
	"data" : "wathever 2-0"
},
{
	"_id" : ObjectId("5b47578f608f74d0e8bf0738"),
	"deviceId" : 2,
	"timestamp" : ISODate("2018-05-18T00:00:00Z"),
	"data" : "wathever 2-2"
},
{
	"_id" : ObjectId("5b47578f608f74d0e8bf0739"),
	"deviceId" : 3,
	"timestamp" : ISODate("2018-01-07T00:00:00Z"),
	"data" : "wathever 3"
}
])

db.rental.aggregate([
  {$lookup:{
    from : "reading",
    let : {start: "$start_date", end: "$end_date", deviceId: "$deviceId"},
    pipeline : [
      {$match: 
         { $expr:
           { $and:
             [
               { $gte: [ "$timestamp",  "$$start" ] },
               { $lte: [ "$timestamp", "$$end" ] },
               { $eq : [ "$deviceId", "$$deviceId"] }
             ]
           }
         }
      }
    ],
    as : "joinField"
  }}

]).pretty()
