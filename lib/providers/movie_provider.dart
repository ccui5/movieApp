import 'package:flutter/material.dart';
import 'package:movieApp/data/mongo.dart';
import 'package:movieApp/models/actor.dart';
import 'package:movieApp/models/common.dart';
import 'package:movieApp/models/movie.dart';
import '../http/imdbServer.dart';

class MovieProvider with ChangeNotifier {
  Movie m;
  MovieProvider() {
    m = new Movie(
        actors: ["actor A", "actor B"],
        points: "3.2",
        director: "director 1",
        time: DateTime.utc(1989, 11, 9),
        imageUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
        commons: [],
        movieName: "name",
        language: "English",
        sketch: "");
  }
  List<String> getActors(dynamic data) {
    List<String> list = new List<String>();
    for (int i = 0; i < data["cre"][0]["cast"].length; i++) {
      list.add(data["cre"][0]["cast"][i]["name"]);
      print(list[i]);
    }
    return list;
  }

  Future<void> getMovie(String name) async {
    dynamic movie = await MongoData.getInstance().getMovieByName(name);
    getActors(movie);
    String url = await getPosterById(movie["imdb_id"]);
    m = new Movie(
      imageUrl: url,
      movieName: movie["original_title"],
      points: movie["vote_average"],
      time: DateTime.parse(movie["release_date"]),
      director: movie["cre"][0]["crew"][0]["name"],
      commons: [],
      actors: getActors(movie),
      sketch: movie["overview"],
      language: movie["original_language"],
    );

    notifyListeners();
  }
}
