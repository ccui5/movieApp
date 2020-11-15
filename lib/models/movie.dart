import 'package:flutter/material.dart';
import 'time.dart';
import 'director.dart';
import 'common.dart';
import 'actor.dart';

class Movie {
  final String imageUrl;
  final String movieName;
  final double points;
  final DateTime time;
  final String director;
  final List<Common> commons;
  final List<String> actors;
  final String language;
  final String year;

  const Movie({
    @required this.imageUrl,
    @required this.movieName,
    @required this.points,
    @required this.time,
    @required this.director,
    @required this.commons,
    @required this.actors,
    @required this.language,
    @required this.year,
  });
}
