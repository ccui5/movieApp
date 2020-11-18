# movieApp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

主要是 lib 文件夹， 其他不用管，
下载安装教程
https://flutter.dev/docs/get-started/install/windows

按照步骤创建一个 project, 将 lib 文件夹以及 pubspec.yaml 替换，就可以在安卓手机上运行

可以运行之后打开 lib 文件夹 里面有一个 providers, 里面是前端要用的数据, 把数据存进这里前端会自动显示

data 文件夹里面是 mongodb class 未完成

#Get the small set of movies by language which is English.
db.movies_metadata.aggregate([
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
}
])

#Get the small set of movies by language which is English( #return is limited to 50).
db.movies_metadata.aggregate([
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
\$limit: 50
}
])

#Get the top20 movies by vote_average.
db.movies_metadata.aggregate([
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
		$project: { \_id: 0, original_title : 1 , vote_average : 1 , poster_path : 1 }
}
])

#Get the top20 movies by revenue.
db.movies_metadata.aggregate([
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
		$project: { \_id: 0, original_title : 1 , revenue : 1 , poster_path : 1 }
}
])

db.movies_metadata.aggregate([
{"$unwind": '$production_companies'},
{
"$group": {
"name": "$production_companies.name",
"num_movies": {"$sum": 1},
"revenue_total": {
"$sum": {"$toLong": "$revenue"}
}
}
},
{
"$sort": {"revenue_total": -1}
},
{"$limit": 20}
])

    db.movies_metadata.aggregate([
    {
    	$unwind: '$production_companies'
    },{
    	$group:
    	{
    		_id : {name:"$production_companies.name"},
    		Num_movies: { $sum: 1 },
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
