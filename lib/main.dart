import 'package:flutter/material.dart';
import 'package:movies/features/movie/list/movie_list.dart';
import 'package:movies/utils/constants.dart' as Constants;
import 'package:movies/utils/ui_constants.dart' as UiConstants;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      theme: ThemeData(
        primarySwatch: UiConstants.PRIMARY_MATERIAL_COLOR,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MovieListPage(),
    );
  }
}
