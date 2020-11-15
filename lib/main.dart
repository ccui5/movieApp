import 'package:flutter/material.dart';
import 'package:movieApp/providers/actor_provider.dart';
import 'package:movieApp/providers/company_provider.dart';
import 'package:movieApp/providers/movie_provider.dart';
import 'package:movieApp/providers/tag_provider.dart';
import 'package:movieApp/screens/actorScreen.dart';
import 'package:movieApp/screens/companyScreen.dart';
import 'package:movieApp/screens/initScreen.dart';
import 'package:movieApp/screens/tagScreen.dart';
import 'package:provider/provider.dart';
import 'package:movieApp/providers/init_provider.dart';
import 'package:movieApp/screens/movieDetail.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InitProvider initProvider;
  MovieProvider movieProvider;
  ActorProvider actorProvider;
  TagProvider tagProvider;
  CompanyProvider companyProvider;
  @override
  void initState() {
    initProvider = new InitProvider();
    movieProvider = new MovieProvider();
    actorProvider = new ActorProvider();
    tagProvider = new TagProvider();
    companyProvider = new CompanyProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: initProvider,
        ),
        ChangeNotifierProvider.value(
          value: movieProvider,
        ),
        ChangeNotifierProvider.value(
          value: actorProvider,
        ),
        ChangeNotifierProvider.value(
          value: tagProvider,
        ),
        ChangeNotifierProvider.value(
          value: companyProvider,
        ),
      ],
      child: MaterialApp(
        title: 'study',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Colors.grey[50],
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
                fontSize: 20,
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
                fontSize: 18,
              ),
              headline6: TextStyle(
                fontSize: 15,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              )),
        ),

        initialRoute: '/', // default is '/'
        routes: {
          '/': (ctx) => InitScreen(),
          MovieDetailScreen.routeName: (ctx) =>
              MovieDetailScreen(ModalRoute.of(ctx).settings.arguments),
          ActorScreen.routeName: (ctx) =>
              ActorScreen(ModalRoute.of(ctx).settings.arguments),
          MyTagScreen.routeName: (ctx) =>
              MyTagScreen(ModalRoute.of(ctx).settings.arguments),
          CompanyScreen.routeName: (ctx) => CompanyScreen(),
        },
        onGenerateRoute: (settings) {
          print(settings.arguments);
        },
      ),
    );
  }
}
