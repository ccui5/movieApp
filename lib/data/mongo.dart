import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:tuple/tuple.dart';

class MongoData {
  static MongoData _instance;
  static MongoData getInstance() {
    if (_instance == null) {
      _instance = MongoData();
    }
    return _instance;
  }

  Db db = new Db("mongodb://localhost:27017/moviesdb");
  DbCollection credits;
  DbCollection keywords;
  DbCollection links;
  DbCollection movies_metadata;
  DbCollection ratings_small;

  MongoData() {
    credits = db.collection("credits");
    keywords = db.collection("keywords");
    links = db.collection("links");
    movies_metadata = db.collection("movies_metadata");
    ratings_small = db.collection("ratings_small");
  }

  Future<dynamic> getMovieByName(String name) async {
    await db.open();
    List<dynamic> retVal;
    retVal = await movies_metadata.aggregateToStream([
      {
        "\$match": {"original_title": name}
      },
      {
        "\$lookup": {
          "from": "credits",
          "localField": "id",
          "foreignField": "id",
          "as": "cre"
        }
      },
    ]).toList();
    await db.close();

    return retVal[0];
  }

  Future<List> getCurrentShow() async {
    await db.open();
    List<dynamic> retVal = await movies_metadata.aggregateToStream([
      {
        "\$sort": {"release_date": -1}
      },
      {
        "\$lookup": {
          "from": "links_small",
          "localField": "id",
          "foreignField": "tmdbId",
          "as": "small_links"
        }
      },
      {
        "\$match": {
          "small_links": {"\$ne": []},
          "original_language": "en",
        }
      },
      {"\$limit": 8},
      {
        "\$project": {
          "_id": 0,
          "original_title": 1,
          "vote_average": 1,
          "release_date": 1,
          "imdb_id": 1,
        }
      }
    ]).toList();
    print(retVal);
    await db.close();
    return retVal;
  }

  Future<List> filterMovies(
    List<String> tags,
    String language,
    Tuple2<int, int> year,
  ) async {
    await db.open();
    List<dynamic> retVal;
    print(tags.toString() + "  language: " + language);
    retVal = await movies_metadata.find({
      "\$query": {
        "genres.name": {"\$all": tags},
        "original_language": language,
        "release_date": {
          "\$gt": year.item1.toString(),
          "\$lt": year.item2.toString()
        }
      },
      "\$orderby": {"vote_average": -1}
    }).toList();
    db.close();

    return retVal;
  }

//by average rate
  Future<List> getTopMovie() async {
    await db.open();

    List<dynamic> retVal = await movies_metadata.aggregateToStream([
      {
        "\$sort": {"vote_average": -1}
      },
      {
        "\$lookup": {
          "from": "links_small",
          "localField": "id",
          "foreignField": "tmdbId",
          "as": "small_links"
        }
      },
      {
        "\$match": {
          "small_links": {"\$ne": []}
        }
      },
      {"\$limit": 20},
      {
        "\$project": {
          "_id": 0,
          "original_title": 1,
          "vote_average": 1,
          "poster_path": 1,
          "imdb_id": 1,
          "release_date": 1
        }
      }
    ]).toList();
    db.close();
    return retVal;
  }

  Future<List> getTopRevenue() async {
    await db.open();

    List<dynamic> retVal = await movies_metadata.aggregateToStream([
      {
        "\$addFields": {
          "convertedRevenue": {"\$toLong": "\$revenue"}
        }
      },
      {
        "\$sort": {"convertedRevenue": -1}
      },
      {
        "\$lookup": {
          "from": "links_small",
          "localField": "id",
          "foreignField": "tmdbId",
          "as": "small_links"
        }
      },
      {
        "\$match": {
          "small_links": {"\$ne": []}
        }
      },
      {"\$limit": 20},
      {
        "\$project": {
          "_id": 0,
          "original_title": 1,
          "vote_average": 1,
          "imdb_id": 1,
          "release_date": 1,
          "revenue": 1,
        }
      },
    ]).toList();

    retVal.forEach((element) {
      print(element["revenue"]);
    });
    await db.close();
    return retVal;
  }

  Future<List> getTopCompaniesByReveue() async {
    await db.open();
    List<dynamic> retVal = new List<dynamic>();

    retVal = await movies_metadata.aggregateToStream([
      {"\$unwind": '\$production_companies'},
      {
        "\$group": {
          "_id": "\$production_companies",
          "num_movies": {"\$sum": 1},
          "revenue_total": {
            "\$sum": {"\$toLong": "\$revenue"}
          }
        }
      },
      {
        "\$sort": {"revenue_total": -1}
      },
      {"\$limit": 20}
    ]).toList();

    await db.close();
    return retVal;
  }

  Future<List> getTopCompaniesByNumMovies() async {
    await db.open();
    List<dynamic> retVal = new List<dynamic>();
    retVal = await movies_metadata.aggregateToStream([
      {"\$unwind": '\$production_companies'},
      {
        "\$group": {
          "_id": "\$production_companies",
          "count": {"\$sum": 1}
        }
      },
      {
        "\$sort": {"count": -1}
      },
      {"\$limit": 20}
    ]).toList();

    await db.close();
    return retVal;
  }

  Future<List> getCountryMovies() async {
    await db.open();
    List<dynamic> retVal = new List<dynamic>();
    retVal = await movies_metadata.aggregateToStream([
      {
        "\$match": {
          "production_countries.name": {"\$exists": true, "\$ne": null}
        }
      },
      {"\$unwind": '\$production_countries'},
      {
        "\$group": {
          "_id": "\$production_countries.name",
          "count": {"\$sum": 1}
        }
      },
      {
        "\$sort": {"count": -1}
      },
      {"\$limit": 20}
    ]).toList();

    await db.close();
    return retVal;
  }

  Future<List> getCountryRevenue() async {
    await db.open();
    List<dynamic> retVal = new List<dynamic>();
    retVal = await movies_metadata.aggregateToStream([
      {
        "\$match": {
          "production_countries.name": {"\$exists": true, "\$ne": null}
        }
      },
      {"\$unwind": '\$production_countries'},
      {
        "\$group": {
          "_id": "\$production_countries.name",
          "\count": {"\$sum": 1},
          "revenue_total": {
            "\$sum": {"\$toLong": "\$revenue"}
          }
        }
      },
      {
        "\$sort": {"revenue_total": -1}
      },
      {"\$limit": 20}
    ]).toList();

    await db.close();

    return retVal;
  }
}
