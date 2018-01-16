// Aggregations => https://docs.mongodb.com/manual/reference/operator/aggregation/

// Un find... en aggrégation
db.movies.aggregate([
		{
			$match : { // Même fonctionnement que find()
				"year" : 1999
			}
		}
	])

// Nombre de films par année pour les années > 1970
db.movies.aggregate([
		{
			$match : { 
				"year" : {
					$gt : 1970
				}
			}
		}, {
			$group : {
				"_id" : "$year", // Clé de groupage
				"count" : {
					$sum : 1  //  On compte le nombre d'éléments par années
				}
			}
		}
	])

db.movies.count()
// est équivalent à :
db.movies.aggregate([
	{
		$group : {
			"_id" : null,
			"count" : {
				$sum : 1
			}
		}
	}
])

// Changement de la clé de groupage et utilisation d'un autre opérateur de groupage
db.movies.aggregate([
	{
			$group : {
				"_id" : { // La clé peut être composée
					"first_name" : "$director.first_name",
					"last_name" : "$director.last_name"
				}, 
				"years" : {
					$addToSet : "$year" // Ajout avec unicité
				}
			}
		}
	])

// Affichage des prénoms de réalisateurs de films dont la note imdb est supérieure à 7
db.movies.aggregate([
	{
		$match : {
			"imdb" : {
				$gt : 7
			}
		}
	}, {
		$project : {
			"director.first_name" : 1 // Pareil que la deuxième partie du find()
		}
	}
])

// Affichage des prénoms de réalisateurs de films dont la note imdb est supérieure à 7, version différente
db.movies.aggregate([
	{
		$match : {
			"imdb" : {
				$gt : 7
			}
		}
	}, {
		$project : {
			"firstname" : "$director.last_name", // On transforme un champs
			"name" : {
				$concat : [ "$director.last_name", " ", "$director.first_name" ]
			},
			"genre_upper" : {
				$toUpper : "$genre"
			},
			"imdb_times_10" : {
				$multiply : ["$imdb",10]
			},
			"year_minus_50" : {
				$subtract : ["$year",50]
			}
		}
	}
])

// => Essayez quelques opérateurs de projection issus de la doc

// Même fonctionnement que les sort/skip/limit du requêtage normal
db.movies.aggregate([
	{
		$sort : { "year" : 1 }
	},
	{
		$skip : 10
	}, 
	{
		$limit : 5
	}
])


// Explosion d'un tableau

db.movies.aggregate([
	{
		$project : {
			"actors" : 1,
			"_id" : 0
		}
	},
	{
		$unwind : "$actors"		
	}
])


// Envoi dans une collection de sortie => WARNING, vous écrasez la collection si elle existe
db.movies.aggregate([
	{
		$match : {
			"imdb" : {
				$gt : 7
			}
		}
	}, {
		$project : {
			"firstname" : "$director.last_name", // On transforme un champs
			"name" : {
				$concat : [ "$director.last_name", " ", "$director.first_name" ]
			},
			"genre_upper" : {
				$toUpper : "$genre"
			},
			"imdb_times_10" : {
				$multiply : ["$imdb",10]
			},
			"year_minus_50" : {
				$subtract : ["$year",50]
			}
		}
	},{
		$out : "res_collection"
	}
])


