import 'package:flutter/material.dart';

class CoverItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String point;

  CoverItem({
    @required this.name,
    @required this.imageUrl,
    @required this.point,
  });
  void chooseMovie(String name) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(children: <Widget>[
        Container(
          height: 120,
          width: 100,
          child: FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/MovieDetailScreen',
                  arguments: name);
            },
            child: Image(
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        Container(
          height: 45,
          child: Text(name),
        ),
        Text(
          point.toString(),
        ),
      ]),
    );
  }
}
