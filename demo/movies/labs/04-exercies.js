// Exercices un peu plus complexes ;-)

// Fournir l'ensemble des acteurs uniques (unicité sur prénom/nom)

db.movies.aggregate([
	{
		$unwind : "$actors"
	},
	{
		$group : {
			_id  : {
				"first_name" : "$actors.first_name",
				"last_name" : "$actors.last_name",
			}
		}
	},
	{
		$project : { // On rend tout ça plus joli
			"_id" : 0,
			"first_name" : "$_id.first_name",
			"last_name" : "$_id.last_name",
		}
	}
])

// Alternativement (un peu plus complexe) 

db.movies.aggregate([
	{
		$unwind : "$actors"
	},
	{
		$group : {
			_id : null,
			actors : {
				$addToSet : {
					"first_name" : "$actors.first_name",
					"last_name" : "$actors.last_name",
				}
			}
		}
	},
	{
		$unwind : "$actors"
	},
	{
		$project : { // On rend tout ça plus joli
			"_id" : 0,
			"first_name" : "$actors.first_name",
			"last_name" : "$actors.last_name",
		}
	}
])

// Pour chaque réalisateur, lister les acteurs par ordre de nombre d'apparition dans ses films (décroissant)

db.movies.aggregate([
	{
		$unwind : "$actors"
	},
	{
		$group : {
			_id : {
				director : {
					first_name : "$director.first_name",
					last_name : "$director.last_name"
				},
				actor : {
					first_name : "$actors.first_name",
					last_name : "$actors.last_name"
				}
			},
			count : {
				$sum : 1
			}
		}
	},
	{
		$sort : {
			count : -1
		}
	},
	{
		$group : {
			_id : {
				director : {
					first_name : "$_id.director.first_name",
					last_name : "$_id.director.last_name"
				}
			},
			actors : {
				$addToSet : {
					first_name : "$_id.actor.first_name",
					last_name : "$_id.actor.last_name",
					count : "$count"
				}
			}
		}
	}
])

// Pour chaque réalisateur, noter le ou les acteurs avec qui il a le plus travaillé

db.movies.aggregate([
	{
		$unwind : "$actors"
	},
	{
		$group : {
			_id : {
				director : {
					first_name : "$director.first_name",
					last_name : "$director.last_name"
				},
				actor : {
					first_name : "$actors.first_name",
					last_name : "$actors.last_name"
				}
			},
			count : {
				$sum : 1
			}
		}
	},
	{
		$group : {
			_id : {
				first_name : "$_id.director.first_name",
				last_name : "$_id.director.last_name",
				count : "$count"
			},
			actors : {
				$addToSet : {
					first_name : "$_id.actor.first_name",
					last_name : "$_id.actor.last_name"
				}
			}
		}
	},
	{
		$sort : {
			"_id.count" : -1
		}
	},
	{
		$group : {
			_id : {
				first_name : "$_id.first_name",
				last_name : "$_id.last_name",
			},
			actors : {
				$first : "$actors"
			}
		}
	}
])

