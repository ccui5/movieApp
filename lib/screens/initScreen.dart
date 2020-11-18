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
    getData();
    super.initState();
  }

  Future<void> getData() async {
    await initProvider.getCurrentShow();
    await initProvider.getTopRateMovies();
    await initProvider.getTopRevenueMovies();
    await initProvider.getTopRevenueCompanies();
    await initProvider.getTopNumCompanies();
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
        margin: EdgeInsets.only(top: 5, bottom: 5),
        padding: EdgeInsets.only(left: 2, right: 2),
        child: Text(
            companies[i].name + "  rate: " + companies[i].earning.toString()),
      ));
    }

    return retVal;
  }

  List<Widget> mostCommonList(List<Cover> covers) {
    List<Widget> returnVal = new List<Widget>();
    for (int i = 0; i < covers.length; i++) {
      returnVal.add(
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          padding: EdgeInsets.only(left: 2, right: 2),
          child: Row(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                child: FlatButton(
                  onPressed: () => chooseMovie(covers[i].movie_name),
                  child: Image(
                    image: NetworkImage(covers[i].image_url),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 300,
                    child: Text(covers[i].movie_name),
                  ),
                  Container(
                    child: Text(covers[i].points),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
    return returnVal;
  }

  List<Widget> coverList(List<Cover> covers) {
    List<Widget> returnVal = new List<Widget>();
    for (int i = 0; i < covers.length; i++) {
      returnVal.add(
        Container(
          width: 150,
          child: Column(
            children: <Widget>[
              Container(
                height: 150,
                child: FlatButton(
                  onPressed: () => chooseMovie(covers[i].movie_name),
                  child: Image(
                    image: NetworkImage(covers[i].image_url),
                  ),
                ),
              ),
              Container(height: 50, child: Text(covers[i].movie_name)),
              Container(
                height: 25,
                child: Text(covers[i].year.toString()),
              )
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
                  Container(
                    child: Text(
                      "current showing",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.green[200],
                  ),
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<InitProvider>(
                        builder: (context, u, child) => Row(
                          children: coverList(u.currentShowing),
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
                            child: Text('Country infomations'),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/CountryInfoScreen');
                            },
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
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    padding: EdgeInsets.only(left: 2, right: 2),
                    child: Text(
                      "Top 20 movies by average rate",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    color: Colors.blue[100],
                  ),
                  Container(
                    child: Consumer<InitProvider>(
                      builder: (context, u, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: mostCommonList(u.topRate),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    padding: EdgeInsets.only(left: 2, right: 2),
                    child: Text(
                      "Top 20 revenue movies",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    color: Colors.yellow[100],
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
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    padding: EdgeInsets.only(left: 2, right: 2),
                    child: Text(
                      "Top 20 high-producig Companies ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    color: Colors.grey,
                  ),
                  Container(
                    child: Consumer<InitProvider>(
                      builder: (context, u, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: companiesWidet(u.companiesByNum),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Top 20 revenue compaines",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    color: Colors.green[100],
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
