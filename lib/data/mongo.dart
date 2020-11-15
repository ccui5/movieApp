import 'package:mongo_dart/mongo_dart.dart';

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

  Future<List> getMovieByName(String name) async {
    await db.open();
    List<dynamic> retVal;

    retVal = await movies_metadata.find().toList();

    await db.close();

    return retVal;
  }
}
