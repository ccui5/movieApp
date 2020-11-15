import 'package:flutter/material.dart';
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
    years = new List<Tuple2<int, int>>();

    for (int i = 1950; i < 2020; i += 10) {
      years.add(Tuple2(i, i + 9));
    }

    covers = new List<Cover>();
    choosedTag = new List<String>();

    covers = [
      Cover(
        image_url:
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        movie_name: 'name',
        points: 6.5,
        common: Common(common: "common 12345", points: 5.3),
        year: 2015,
      ),
      Cover(
        image_url:
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        movie_name: 'name',
        points: 6.5,
        common: Common(common: "common 12345", points: 5.3),
        year: 2019,
      ),
      Cover(
        image_url:
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        movie_name: 'name',
        points: 6.5,
        common: Common(common: "common 12345", points: 5.3),
        year: 2019,
      ),
      Cover(
        image_url:
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        movie_name: 'name',
        points: 6.5,
        common: Common(common: "common 12345", points: 5.3),
        year: 2019,
      ),
      Cover(
        image_url:
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        movie_name: 'name',
        points: 6.5,
        common: Common(common: "common 12345", points: 5.3),
        year: 2019,
      ),
      Cover(
        image_url:
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        movie_name: 'name',
        points: 6.5,
        common: Common(common: "common 12345", points: 5.3),
        year: 2019,
      ),
      Cover(
        image_url:
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        movie_name: 'name',
        points: 6.5,
        common: Common(common: "common 12345", points: 5.3),
        year: 2019,
      ),
      Cover(
        image_url:
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        movie_name: 'name',
        points: 6.5,
        common: Common(common: "common 12345", points: 5.3),
        year: 2019,
      ),
      Cover(
        image_url:
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        movie_name: 'name',
        points: 6.5,
        common: Common(common: "common 12345", points: 5.3),
        year: 2019,
      ),
      Cover(
        image_url:
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        movie_name: 'name',
        points: 6.5,
        common: Common(common: "common 12345", points: 5.3),
        year: 2019,
      ),
    ];
  }
  void getCoversByTag(List<String> tags) {}

  void chooseTag(String s) {
    print(s);
    if (!choosedTag.contains(s)) choosedTag.add(s);
    notifyListeners();
  }

  void chooseYear(int i) {
    choosedYear = years[i];
    notifyListeners();
  }
}
