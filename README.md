# movieApp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Author: Chuanglin Cui, Yanchen Guo

how to use:
open a simulator of ios or android
use vscode run main file in lib

all code are in lib,
mogodb connection and querys are in lib/data/mongo.dart

providers contains the data that needs to show in the front-end, providers will call the functions in the mongo.dart, load the data from database, and renew the front-end each time

screens folder contains the wigits tree that display on the screens. the main screen is initScreen, this contains the current showing, top movies and top compaines' information and posters (5 querys).

click language in the top of initScreen will go to tagScreen, users can find movies by click the tags and time, user can select multiple tags if needed, they can also cancle tags by click same buttom again(for example, people can click [action, Drama,...], once user click action again, this tag will be cancle in the tags)

click contry info buttom in the initScreen will go to CountryInfoScreen, this shows the data of #movies, revenues and revenues/#movies data of each country(3 querys)

click any poster of movies will go to movies detailScreen which shows the information of actors, keywords, dirctors, and average points of the movie
