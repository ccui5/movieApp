import 'package:flutter/material.dart';
import 'package:movieApp/models/actor.dart';
import 'package:movieApp/models/common.dart';
import 'package:movieApp/models/cover.dart';
import 'package:movieApp/models/movie.dart';

class ActorProvider with ChangeNotifier {
  Actor actor;

  ActorProvider() {}

  void getActor(String name) {} //get actors information by movie name
}
