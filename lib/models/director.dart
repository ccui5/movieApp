import 'package:flutter/material.dart';
import 'package:movieApp/models/actor.dart';
import 'cover.dart';

class Director {
  final String name;
  final double points;
  const Director({
    @required this.points,
    @required this.name,
  });
}
