import 'package:flutter/material.dart';
import 'package:movieApp/data/mongo.dart';
import 'package:movieApp/http/imdbServer.dart';
import 'package:movieApp/models/actor.dart';
import 'package:movieApp/models/common.dart';
import 'package:movieApp/models/cover.dart';
import 'package:movieApp/screens/CountryInfo.dart';
import 'package:tuple/tuple.dart';

class CountryInfoProvider with ChangeNotifier {
  Map<String, int> countriesMovies;
  Map<String, int> countriesRevenue;
  Map<String, int> rate;

  CountryInfoProvider() {
    countriesMovies = new Map<String, int>();
    countriesRevenue = new Map<String, int>();
    rate = new Map<String, int>();
  }

  Future<void> loadMovies() async {
    List<dynamic> data = await MongoData.getInstance().getCountryMovies();
    for (int i = 0; i < data.length; i++) {
      countriesMovies[data[i]["_id"]] = data[i]["count"];
    }
    notifyListeners();
  }

  Future<void> loadRevenue() async {
    List<dynamic> data = await MongoData.getInstance().getCountryRevenue();
    for (int i = 0; i < data.length; i++) {
      countriesRevenue[data[i]["_id"]] = data[i]["revenue_total"];
      rate[data[i]["_id"]] =
          (data[i]["revenue_total"] / data[i]["count"]).round();
    }
    notifyListeners();
  }
}
