import 'package:flutter/material.dart';
import 'package:movieApp/models/actor.dart';
import 'package:movieApp/models/common.dart';
import 'package:movieApp/models/movie.dart';

class MovieProvider with ChangeNotifier {
  Movie m;
  MovieProvider() {
    m = new Movie(
        actors: ["actor A", "actor B"],
        points: 3.2,
        director: "director 1",
        time: DateTime.utc(1989, 11, 9),
        imageUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        commons: [
          Common(common: "this is a common", points: 6.2),
          Common(common: "this is a common 2", points: 8.2)
        ],
        movieName: "name",
        language: "English",
        year: "2000");
  }

  void getMovie(String name) {}
}
