import 'package:flutter/material.dart';
import 'package:movieApp/providers/tag_provider.dart';
import 'package:movieApp/widget/cover_wigit.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class MyTagScreen extends StatefulWidget {
  static const String routeName = '/MyTagScreen';
  String language;
  MyTagScreen(this.language);

  @override
  MyTagScreenState createState() => MyTagScreenState();
}

class MyTagScreenState extends State<MyTagScreen> {
  TagProvider tagProvider;

  initState() {
    tagProvider = Provider.of<TagProvider>(context, listen: false);
    tagProvider.language = widget.language;
    super.initState();
  }

  List<Widget> tagsWidgets(List<String> tags) {
    List<Widget> retVal = new List<Widget>();
    for (int i = 0; i < tags.length; i++) {
      retVal.add(
        Container(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white)),
            color: Colors.white,
            child: Text(tags[i]),
            onPressed: () => tagProvider.chooseTag(tags[i]),
          ),
        ),
      );
    }
    return retVal;
  }

  List<Widget> yearWidgets(List<Tuple2<int, int>> years) {
    List<Widget> retVal = new List<Widget>();
    for (int i = 0; i < years.length; i++) {
      retVal.add(
        Container(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white)),
            color: Colors.white,
            child: Text(
                years[i].item1.toString() + " - " + years[i].item2.toString()),
            onPressed: () => tagProvider.chooseYear(i),
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
        child: Consumer<TagProvider>(
          builder: (context, u, child) => Column(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: tagsWidgets(u.tags),
                  ),
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: yearWidgets(u.years),
                  ),
                ),
              ),
              Container(
                height: 500,
                child: GridView.count(
                  children: u.covers
                      .map(
                        (data) => CoverItem(
                          name: data.movie_name,
                          imageUrl: data.image_url,
                          point: data.points.toString(),
                        ),
                      )
                      .toList(),
                  crossAxisCount: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
