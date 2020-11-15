import 'package:flutter/material.dart';
import 'package:movieApp/models/actor.dart';
import 'package:movieApp/models/common.dart';
import 'package:movieApp/models/cover.dart';
import 'package:movieApp/providers/actor_provider.dart';
import 'package:movieApp/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class ActorScreen extends StatefulWidget {
  static const String routeName = '/ActorScreen';
  String actorName;

  ActorScreen(this.actorName);

  @override
  ActorScreenState createState() => ActorScreenState();
}

class ActorScreenState extends State<ActorScreen> {
  ActorProvider actorProvider;

  @override
  void initState() {
    actorProvider = Provider.of<ActorProvider>(context, listen: false);
    super.initState();
  }

  void chooseMovie(String name) {
    Navigator.pushNamed(context, '/MovieDetailScreen', arguments: name);
  }

  List<Widget> movies(List<Cover> covers) {
    List<Widget> retVal = new List<Widget>();
    for (int i = 0; i < covers.length; i++) {
      retVal.add(Container(
        height: 200,
        width: 150,
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () => chooseMovie(covers[i].movie_name),
              child: Image(
                image: NetworkImage(covers[i].image_url),
              ),
            ),
            Text(covers[i].movie_name),
            Text(covers[i].points.toString()),
          ],
        ),
      ));
    }

    return retVal;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.actorName);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 180,
                  width: 250,
                  child: Consumer<ActorProvider>(
                    builder: (context, u, child) => Image(
                      image: NetworkImage(u.actor.imageUrl),
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  child: Consumer<ActorProvider>(
                    builder: (context, u, child) => Column(
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, bottom: 5, left: 50),
                          child: Text(u.actor.name),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Consumer<ActorProvider>(
              builder: (context, u, child) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: movies(u.actor.movieList)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
