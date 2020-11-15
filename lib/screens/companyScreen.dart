import 'package:flutter/material.dart';
import 'package:movieApp/models/actor.dart';
import 'package:movieApp/models/common.dart';
import 'package:movieApp/providers/company_provider.dart';
import 'package:movieApp/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class CompanyScreen extends StatefulWidget {
  static const String routeName = '/CompanyScreen';

  CompanyScreen();

  @override
  CompanyScreenState createState() => CompanyScreenState();
}

class CompanyScreenState extends State<CompanyScreen> {
  CompanyProvider companyProvider;
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    companyProvider = Provider.of<CompanyProvider>(context, listen: false);
    super.initState();
  }

  void searchCompany(String name) {
    companyProvider.searchCompany(name);
  }

  List<Widget> rows(List<String> tags, Map<String, double> map) {
    List<Widget> retVal = new List<Widget>();
    for (int i = 0; i < tags.length; i++) {
      retVal.add(
        Container(
          height: 300,
          width: 100,
          child: Column(
            children: <Widget>[
              Text(tags[i]),
              Text(
                map[tags[i]].toString(),
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
            margin: EdgeInsets.only(top: 3, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 200,
                  child: Text('company name'),
                ),
                Container(
                  width: 100,
                  height: 30,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: controller,
                  ),
                ),
                Container(
                    width: 100,
                    height: 30,
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => searchCompany(controller.text),
                    ))
              ],
            ),
          ),
          Consumer<CompanyProvider>(
            builder: (ctx, u, child) => Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: rows(u.tags, u.companyTagsPersentage),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
