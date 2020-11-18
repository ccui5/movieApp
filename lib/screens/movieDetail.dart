import 'package:flutter/material.dart';
import 'package:movieApp/models/actor.dart';
import 'package:movieApp/models/common.dart';
import 'package:movieApp/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatefulWidget {
  static const String routeName = '/MovieDetailScreen';
  String movieName;

  MovieDetailScreen(this.movieName);

  @override
  MovieDetailScreenState createState() => MovieDetailScreenState();
}

class MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieProvider movieProvider;
  @override
  void initState() {
    movieProvider = Provider.of<MovieProvider>(context, listen: false);

    movieProvider.getMovie(widget.movieName);
    super.initState();
  }

  void goToDirctor(String s) {
    print("go to actor" + s);
    //Navigator.pushNamed(context, '/ActorScreen', arguments: s);
  }

  List<Widget> showActor(List<String> actors) {
    List<Widget> retVal = new List<Widget>();
    for (int i = 0; i < actors.length; i++) {
      retVal.add(Container(
        width: 80,
        child: Row(
          children: <Widget>[
            Container(
              width: 80,
              child: FlatButton(
                onPressed: () => goToDirctor(actors[i]),
                child: Text(actors[i]),
              ),
            ),
          ],
        ),
      ));
    }

    return retVal;
  }

  List<Widget> showCommons(List<Common> commons) {
    List<Widget> retVal = new List<Widget>();
    for (int i = 0; i < commons.length; i++) {
      retVal.add(
        Container(
          width: 350,
          child: Row(
            children: <Widget>[
              Container(
                width: 100,
                child: Text(commons[i].points),
              ),
              Container(
                width: 250,
                child: Text(commons[i].uid),
              ),
            ],
          ),
        ),
      );
    }
    return retVal;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 180,
                  width: 150,
                  child: Consumer<MovieProvider>(
                    builder: (context, u, child) => Image(
                      image: NetworkImage(u.m.imageUrl),
                    ),
                  ),
                ),
                Container(
                  height: 180,
                  child: Consumer<MovieProvider>(
                    builder: (context, u, child) => Column(
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, bottom: 5, left: 50),
                          child: Text(u.m.movieName),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, bottom: 5, left: 50),
                          child: Text(u.m.points.toString()),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, bottom: 5, left: 50),
                          child: Text("director: " + u.m.director),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5, left: 50),
                          child: Text("language: " + u.m.language),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Consumer<MovieProvider>(
                builder: (context, u, _) => Container(
                  child: Text(u.m.sketch),
                ),
              ),
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Consumer<MovieProvider>(
                  builder: (context, u, _) => Row(
                    children: showActor(u.m.actors),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
