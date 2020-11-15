import 'package:flutter/material.dart';
import 'common.dart';

class Cover {
  final String image_url;
  final String movie_name;
  final double points;
  final Common common;
  final int year;

  const Cover({
    @required this.image_url,
    @required this.movie_name,
    @required this.points,
    @required this.common,
    @required this.year,
  });
}
