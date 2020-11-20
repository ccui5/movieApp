import 'package:flutter/material.dart';
import 'package:movieApp/data/mongo.dart';
import 'package:movieApp/http/imdbServer.dart';
import 'package:movieApp/models/common.dart';
import 'package:movieApp/models/company.dart';
import 'package:movieApp/models/cover.dart';
import 'package:movieApp/models/director.dart';

class InitProvider with ChangeNotifier {
  int size = 10;
  List<Cover> currentShowing;
  List<Cover> topRate; //top rate movies information
  List<Company> companies; // top 20 revenue companies
  List<Company> companiesByNum;
  List<Cover> topRevenue; //top 20 revenue movie

  Future<List<Cover>> loadCover(List<dynamic> data) async {
    List<Cover> retVal = new List<Cover>();

    for (int i = 0; i < data.length; i++) {
      String url = await getPosterById(data[i]["imdb_id"]);
      print(url);
      if (url == null) url = "";
      Cover c = new Cover(
          image_url: url,
          movie_name: data[i]["original_title"],
          points: data[i]["vote_average"],
          common: null,
          year: DateTime.parse(data[i]["release_date"]));
      retVal.add(c);
    }
    return retVal;
  }

  Future<void> getCurrentShow() async {
    List<dynamic> data = await MongoData.getInstance().getCurrentShow();
    currentShowing = await loadCover(data);
    notifyListeners();
  }

  Future<List<Company>> loadComp(List<dynamic> data) async {
    List<Company> retVal = new List<Company>();
    for (int i = 1; i < data.length; i++) {
      Company c = new Company(data[i]["_id"]["name"], data[i]["count"]);
      retVal.add(c);
    }

    return retVal;
  }

  Future<List<Company>> loadCompByRev(List<dynamic> data) async {
    List<Company> retVal = new List<Company>();
    for (int i = 1; i < data.length; i++) {
      Company c = new Company(data[i]["_id"]["name"], data[i]["revenue_total"]);
      retVal.add(c);
    }

    return retVal;
  }

  Future<void> getTopRateMovies() async {
    List<dynamic> data = await MongoData.getInstance().getTopMovie();
    topRate = await loadCover(data);
    notifyListeners();
  }

  Future<void> getTopRevenueMovies() async {
    List<dynamic> data = await MongoData.getInstance().getTopRevenue();
    topRevenue = await loadCover(data);
    notifyListeners();
  }

  Future<void> getTopRevenueCompanies() async {
    List<dynamic> data =
        await MongoData.getInstance().getTopCompaniesByReveue();
    companies = await loadCompByRev(data);
    notifyListeners();
  }

  Future<void> getTopNumCompanies() async {
    List<dynamic> data =
        await MongoData.getInstance().getTopCompaniesByNumMovies();
    companiesByNum = await loadComp(data);
    notifyListeners();
  }

  InitProvider() {
    currentShowing = new List<Cover>();
    topRevenue = new List<Cover>();
    companies = new List<Company>();
    companiesByNum = new List<Company>();
    topRate = new List<Cover>();
    currentShowing.add(
      Cover(
        image_url:
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        movie_name: 'name',
        points: "6.5",
        common: Common(uid: "common 12345", points: "5.3"),
        year: null,
      ),
    );
  }
}
