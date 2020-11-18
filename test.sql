Get the small
set
of movies by language which is English
( #return is limited to 50).
db.movies_metadata.aggregate
([
	{ 
		$match: {"original_language":"en"} 
	},
	{ $lookup:
		{
			from: "links_small",
			localField: "id",
			foreignField: "tmdbId",
			as: "small_links"
		}
	},
	{
      $match: { "small_links": { $ne: [] } }
    },
	{
		$limit: 50
	}
])

#2 Get the top20 movies by vote_average.
db.movies_metadata.aggregate
([
	{ 
		$sort: { "vote_average" : -1 }
	},
	{ 	$lookup:
		{
			from: "links_small",
			localField: "id",
			foreignField: "tmdbId",
			as: "small_links"
		}
	},
	{
		$match: { "small_links": { $ne: [] } }
    },
	{
		$limit: 20
	},
	{
		$project: {
_id:
0, original_title : 1 , vote_average : 1 , poster_path : 1 }
	}
])

#3 Get the top20 movies by revenue.
db.movies_metadata.aggregate
([
	{ 
		$sort: { "revenue" : -1 }
	},
	{ 	$lookup:
		{
			from: "links_small",
			localField: "id",
			foreignField: "tmdbId",
			as: "small_links"
		}
	},
	{
		$match: { "small_links": { $ne: [] } }
    },
	{
		$limit: 20
	},
	{
		$project: {
_id:
0, original_title : 1 , revenue : 1 , poster_path : 1 }
	}
])

#4 Get the top20 companies by #Movies.
db.movies_metadata.aggregate
([
	{
		"$unwind": '$production_companies'
	},
	{
		"$group":
		{
			"_id" : "$production_companies",
			"count": { "$sum": 1 }
		}
	},
	{
		"$sort": { "count" : -1 }
	},
	{
		"$limit": 20
	}
])


#5 Get the top20 companies by revenue.
db.movies_metadata.aggregate
([
	{
		$unwind: '$production_companies'
	},
	{
		$group:
		{
			_id : {name:"$production_companies.name"},
			#movies: { $sum: 1 },
			revenue_total : { $sum: {$toLong : "$revenue"} }
		}
	},
	{
		$sort: { revenue_total : -1 }
	},
	{
		$limit: 20
	}
])

#6 #Movies for different country.
db.movies_metadata.aggregate
([
	{
		$match:
		{	
			"production_countries.name":{
				"$exists": true, 
                "$ne": null
			}
		}
	},
	{
		$unwind: '$production_countries'
	},
	{
		$group:
		{
			_id : "$production_countries.name",
			count : {$sum : 1}
		}
	},
	{
		$sort: { count : -1 }
	},
	{
		$limit: 20
	}
])

#7 revenue for different country.
db.movies_metadata.aggregate
([
	{
		$match:
		{	
			"production_countries.name":{
				"$exists": true, 
                "$ne": null
			}
		}
	},
	{
		$unwind: '$production_countries'
	},
	{
		$group:
		{
			_id : "$production_countries.name",
			count : {$sum : 1},
			revenue_total : { $sum: {$toLong : "$revenue"} }
		}
	},
	{
		$sort: { revenue_total : -1 }
	},
	{
		$limit: 20
	}
])


Note:
Compare 6 and 7, we find that China has higher total revenue
with fewer #movies.

#8 Get the average rating for each genres.
db.movies_metadata.aggregate
([
	{
		$unwind: '$genres'
	},
	{
		$group:
		{
			_id : "$genres.name",
			avg_rating : { $avg: {$toDouble : "$vote_average"} }
		}
	},
	{
		$sort: { avg_rating : -1 }
	}
])

#9 Get the average rating for each genres.
db.movies_metadata.aggregate
([
	{
		$unwind: '$genres'
	},
	{
		$group:
		{
			_id : "$genres.name",
			count : {$sum : 1},
		}
	},
	{
		$sort: { count : -1 }
	}
])


db.movies_metadata.aggregate
([
	{ 
		$match: {"original_language":"en"} 
	},
	{ $lookup:
		{
			from: "credits",
			localField: "id",
			foreignField: "id",
			as: "cre"
		}
	},
	{
		$limit: 50
	},
	{
	$project: { _id: 0, original_title : 1 , vote_average : 1 , cast: 1 }
	}
])