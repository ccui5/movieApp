import 'package:flutter/material.dart';
import 'package:movieApp/models/actor.dart';
import 'package:movieApp/models/common.dart';
import 'package:movieApp/models/cover.dart';

class CompanyProvider with ChangeNotifier {
  List<String> tags;
  Map<String, double>
      companyTagsPersentage; //the persentage of each tag in the company
  CompanyProvider() {
    companyTagsPersentage = Map<String, double>();
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
  }

  void searchCompany(String name) {
    notifyListeners();
  }

  /* get the persentage of each tag in the company*/
  Future<void> getPersentage(String companyName) async {}
}
