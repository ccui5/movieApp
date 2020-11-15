import 'package:flutter/material.dart';
import 'package:movieApp/models/common.dart';
import 'package:movieApp/models/company.dart';
import 'package:movieApp/models/cover.dart';
import 'package:movieApp/models/director.dart';
import 'package:movieApp/models/movie.dart';
import 'package:movieApp/providers/init_provider.dart';
import 'package:provider/provider.dart';

class InitScreen extends StatefulWidget {
  String routeName = '/InitScreen';

  InitScreen();

  @override
  InitScreenState createState() => InitScreenState();
}

class InitScreenState extends State<InitScreen> {
  InitProvider initProvider;
  @override
  void initState() {
    initProvider = Provider.of<InitProvider>(context, listen: false);
    initProvider.getMovie();
    super.initState();
  }

  void goToCompanyScreen() {
    Navigator.pushNamed(context, '/CompanyScreen');
  }

  void chooseMovie(String name) {
    Navigator.pushNamed(context, '/MovieDetailScreen', arguments: name);
  }

  void chooseTag(String tag) {
    Navigator.pushNamed(context, '/MyTagScreen', arguments: tag);
  }

  //show companies earning
  List<Widget> companiesWidet(List<Company> companies) {
    List<Widget> retVal = new List<Widget>();
    for (int i = 0; i < companies.length; i++) {
      retVal.add(Container(
        padding: EdgeInsets.only(left: 2, right: 2),
        child: Text(
            companies[i].name + "  rate: " + companies[i].earning.toString()),
      ));
    }

    return retVal;
  }

  List<Widget> stringWidet(List<Director> directors) {
    List<Widget> retVal = new List<Widget>();
    for (int i = 0; i < directors.length; i++) {
      retVal.add(Container(
        padding: EdgeInsets.only(left: 2, right: 2),
        child: Text(
            directors[i].name + "  rate: " + directors[i].points.toString()),
      ));
    }

    return retVal;
  }

  List<Widget> mostCommonList(List<Cover> covers) {
    List<Widget> returnVal = new List<Widget>();
    for (int i = 0; i < covers.length; i++) {
      returnVal.add(
        Container(
          padding: EdgeInsets.only(left: 2, right: 2),
          child: Row(
            children: <Widget>[
              Container(
                height: 90,
                width: 100,
                child: FlatButton(
                  onPressed: () => chooseMovie(covers[i].movie_name),
                  child: Image(
                    image: NetworkImage(covers[i].image_url),
                  ),
                ),
              ),
              Text(covers[i].movie_name +
                  "\t\trate: " +
                  covers[i].points.toString()),
            ],
          ),
        ),
      );
    }
    return returnVal;
  }

  List<Widget> coverList(int num, String name, String url) {
    List<Widget> returnVal = new List<Widget>();
    for (int i = 0; i < 10; i++) {
      returnVal.add(
        Container(
          height: 150,
          width: 150,
          child: Column(
            children: <Widget>[
              FlatButton(
                onPressed: () => chooseMovie(name),
                child: Image(
                  image: NetworkImage(url),
                ),
              ),
              Text(name)
            ],
          ),
        ),
      );
    }
    return returnVal;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        color: Colors.white,
                        child: Text('English'),
                        onPressed: () => chooseTag("English"),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        color: Colors.white,
                        child: Text('Chinese'),
                        onPressed: () => chooseTag("Chinese"),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        color: Colors.white,
                        child: Text('French'),
                        onPressed: () => chooseTag("French"),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        color: Colors.white,
                        child: Text('Russian'),
                        onPressed: () => chooseTag("Russian"),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        color: Colors.white,
                        child: Text('Japanese'),
                        onPressed: () => chooseTag("Japanese"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3, bottom: 3),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("current showing"),
                    ],
                  ),
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<InitProvider>(
                        builder: (context, u, child) => Row(
                          children: coverList(
                            u.currentShowing.length,
                            "name",
                            u.currentShowing[0].image_url,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3, bottom: 3),
              child: Column(
                children: <Widget>[
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)),
                            color: Colors.white,
                            child: Text('Average rate of tags'),
                            onPressed: () => () {},
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)),
                            color: Colors.white,
                            child: Text('tag persentage of companies'),
                            onPressed: () => goToCompanyScreen(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Text("Top 20 movies"),
                  ),
                  Container(
                    child: Consumer<InitProvider>(
                      builder: (context, u, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: mostCommonList(u.currentShowing),
                      ),
                    ),
                  ),
                  Container(
                    child: Text("Top 20 directors"),
                  ),
                  Container(
                    child: Consumer<InitProvider>(
                      builder: (context, u, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: stringWidet(u.directors),
                      ),
                    ),
                  ),
                  Container(
                    child: Text("Top 20 revenue movies"),
                  ),
                  Container(
                    child: Consumer<InitProvider>(
                      builder: (context, u, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: mostCommonList(u.topRevenue),
                      ),
                    ),
                  ),
                  Container(
                    child: Text("Top 20 revenue compaines"),
                  ),
                  Container(
                    child: Consumer<InitProvider>(
                      builder: (context, u, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: companiesWidet(u.companies),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
