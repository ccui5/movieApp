import 'package:flutter/material.dart';
import 'package:movieApp/data/mongo.dart';
import 'package:movieApp/models/common.dart';
import 'package:movieApp/models/company.dart';
import 'package:movieApp/models/cover.dart';
import 'package:movieApp/models/director.dart';

class InitProvider with ChangeNotifier {
  int size = 10;
  List<Cover> currentShowing;
  List<Cover> topRate; //top rate movies information
  List<Director> directors; //top 20 best directors
  List<Company> companies; // top 20 revenue companies
  List<Cover> topRevenue; //top 20 revenue movie

  Future<void> getMovie() async {
    List<dynamic> movies = await MongoData.getInstance().getMovieByName("name");
    print(movies[1]);
    notifyListeners();
  }

  Future<void> getTopRateMovies() async {}
  Future<void> getTopRateDirctors() async {}
  Future<void> getTopRevenueMovies() async {}
  Future<void> getTopRateCompanies() async {}

  InitProvider() {
    currentShowing = new List<Cover>();
    topRevenue = new List<Cover>();
    directors = new List<Director>();
    companies = new List<Company>();

    topRate = new List<Cover>();
    currentShowing.add(
      Cover(
        image_url:
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        movie_name: 'name',
        points: 6.5,
        common: Common(common: "common 12345", points: 5.3),
        year: 1995,
      ),
    );
  }
}
