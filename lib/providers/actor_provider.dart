import 'package:flutter/material.dart';
import 'package:movieApp/models/actor.dart';
import 'package:movieApp/models/common.dart';
import 'package:movieApp/models/cover.dart';
import 'package:movieApp/models/movie.dart';

class ActorProvider with ChangeNotifier {
  Actor actor;

  ActorProvider() {
    actor = new Actor(
      name: "actor A",
      imageUrl:
          "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3182201706,1164209029&fm=26&gp=0.jpg",
      movieList: [
        Cover(
          image_url:
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          movie_name: "name 1",
          points: 9.9,
          common: Common(common: "common 1", points: 9.2),
          year: null,
        ),
        Cover(
          image_url:
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          movie_name: "name 1",
          points: 9.9,
          common: Common(common: "common 1", points: 9.2),
          year: null,
        ),
        Cover(
          image_url:
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          movie_name: "name 1",
          points: 9.9,
          common: Common(common: "common 1", points: 9.2),
          year: null,
        ),
      ],
      relateActors: ["relate actor1", "relate actor 2", "relate actor 3"],
    );
  }

  void getActor(String name) {} //get actors information by movie name
}
