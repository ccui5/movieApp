import 'package:flutter/material.dart';
import 'package:movieApp/data/mongo.dart';
import 'package:movieApp/http/imdbServer.dart';
import 'package:movieApp/models/actor.dart';
import 'package:movieApp/models/common.dart';
import 'package:movieApp/models/cover.dart';
import 'package:tuple/tuple.dart';

class TagProvider with ChangeNotifier {
  List<String> tags;
  List<String> choosedTag;
  List<Cover> covers;
  List<Tuple2<int, int>> years;
  Tuple2<int, int> choosedYear;
  String language;
  Map<String, String> languageMap;
  TagProvider() {
    tags = [
      "Action",
      "Drama",
      "History",
      "Adventure",
      "Crime",
      "popularity",
      "Fantasy",
      "Comedy",
      "Family",
      "Animation",
      "Romance"
    ];
    languageMap = {
      "English": "en",
      "Chinese": "cn",
      "French": "fr",
      "Russian": "ru",
      "Japanese": "ja"
    };

    years = new List<Tuple2<int, int>>();

    for (int i = 1980; i < 2020; i += 10) {
      years.add(Tuple2(i, i + 9));
    }
    choosedYear = years[3];

    covers = new List<Cover>();
    choosedTag = new List<String>();
  }
  Future<void> chooseTag(String s) async {
    covers = new List<Cover>();

    if (!choosedTag.contains(s)) {
      choosedTag.add(s);
    } else {
      choosedTag.remove(s);
    }
    List<dynamic> dataList = await MongoData.getInstance()
        .filterMovies(choosedTag, language, choosedYear);

    for (int i = 0; i < dataList.length; i++) {
      String url = await getPosterById(dataList[i]["imdb_id"]);
      print(url);
      covers.add(Cover(
          image_url: url,
          movie_name: dataList[i]["original_title"],
          points: dataList[i]["vote_average"],
          common: null,
          year: null));
      if (i == 30) break;
      notifyListeners();
    }

    notifyListeners();
  }

  Future<void> chooseYear(int i) async {
    choosedYear = years[i];
    covers = new List<Cover>();

    List<dynamic> dataList = await MongoData.getInstance()
        .filterMovies(choosedTag, language, choosedYear);

    for (int i = 0; i < dataList.length; i++) {
      String url = await getPosterById(dataList[i]["imdb_id"]);
      print(url);
      covers.add(Cover(
          image_url: url,
          movie_name: dataList[i]["original_title"],
          points: dataList[i]["vote_average"],
          common: null,
          year: null));
      if (i == 30) break;
      notifyListeners();
    }

    notifyListeners();
  }

  void setLanguage(String language) {
    this.language = languageMap[language];
    covers = new List<Cover>();
    choosedTag = new List<String>();
  }
}
