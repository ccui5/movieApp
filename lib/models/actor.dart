import 'package:flutter/material.dart';
import 'cover.dart';

class Actor {
  final String name;
  final String imageUrl;
  final List<Cover> movieList;
  final List<String> relateActors;

  const Actor({
    @required this.name,
    @required this.imageUrl,
    @required this.movieList,
    @required this.relateActors,
  });
}
