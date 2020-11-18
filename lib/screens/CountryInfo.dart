import 'package:flutter/material.dart';
import 'package:movieApp/models/actor.dart';
import 'package:movieApp/models/common.dart';
import 'package:movieApp/providers/company_provider.dart';
import 'package:movieApp/providers/countryInfo_provider.dart';
import 'package:movieApp/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class CountryInfoScreen extends StatefulWidget {
  static const String routeName = '/CountryInfoScreen';

  CountryInfoScreen();

  @override
  CountryInfoScreenState createState() => CountryInfoScreenState();
}

class CountryInfoScreenState extends State<CountryInfoScreen> {
  TextEditingController controller = new TextEditingController();
  CountryInfoProvider countryInfoProvider;
  @override
  void initState() {
    // TODO: implement initState
    countryInfoProvider =
        Provider.of<CountryInfoProvider>(context, listen: false);
    helper();
    super.initState();
  }

  Future<void> helper() async {
    await countryInfoProvider.loadMovies();
    await countryInfoProvider.loadRevenue();
  }

  List<Widget> rows(Map<String, int> map) {
    List<Widget> retVal = new List<Widget>();
    for (int i = 0; i < map.keys.toList().length; i++) {
      retVal.add(
        Container(
          height: 150,
          width: 150,
          child: Column(
            children: <Widget>[
              Text(map.keys.toList()[i]),
              Text(
                map[map.keys.toList()[i]].toString(),
              ),
            ],
          ),
        ),
      );
    }
    return retVal;
  }

  List<Widget> rateRow(Map<String, String> map) {
    List<Widget> retVal = new List<Widget>();
    for (int i = 0; i < map.keys.toList().length; i++) {
      retVal.add(
        Container(
          height: 150,
          width: 100,
          child: Column(
            children: <Widget>[
              Text(map.keys.toList()[i]),
              Text(
                map[map.keys.toList()[i]],
              ),
            ],
          ),
        ),
      );
    }
    return retVal;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              "# movies produced by Country",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            color: Colors.green[100],
          ),
          Consumer<CountryInfoProvider>(
            builder: (ctx, u, child) => Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: rows(u.countriesMovies),
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              "Country revenues",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            color: Colors.green[100],
          ),
          Consumer<CountryInfoProvider>(
            builder: (ctx, u, child) => Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: rows(u.countriesRevenue),
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              "Rate",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            color: Colors.green[100],
          ),
          Consumer<CountryInfoProvider>(
            builder: (ctx, u, child) => Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: rows(u.rate),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
