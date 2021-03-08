import 'package:flutter/material.dart';
import 'package:movies/customwidgets/cells/movie_cell.dart';
import 'package:movies/features/movie/detail/movie_detail.dart';
import 'package:movies/features/movie/favourites/movie_favourites.dart';
import 'package:movies/features/movie/list/movie_list_controller.dart' as controller;
import 'package:movies/features/movie/search/movie_search.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/utils/constants.dart' as Constants;
import 'package:movies/utils/ui_constants.dart' as UiConstants;
import 'package:movies/utils/images.dart' as Images;

class MovieListPage extends StatefulWidget {
  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieListPage> {
  var showLoading = true;
  var showError = false;
  List<Movie> movies = [];
  var page = 1;

  Future<void> getData() async {
    showLoading = true;
    var data = await controller.requestMovies(page);
    setState(() {
      showLoading = false;
      if (data != null) {
        showError = false;
        var result = data['results'];
        for (Map map in result) {
          movies.add(Movie.fromJson(map));
        }
        page++;
      } else {
        showError = true;
      }
    });
  }

  Future<void> refreshData() async {
    page = 1;
    getData();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Constants.APP_NAME),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MovieSearchPage()),
                );
              },
            ),IconButton(
              icon: Icon(Icons.favorite_border, color: Colors.yellow),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MovieFavouritesPage()),
                );
              },
            )
          ],
        ),
        body: showLoading
            ? loadingWidget()
            : showError ? errorWidget() : mainWidget());
  }

  Widget mainWidget() {
    return RefreshIndicator(
      onRefresh: refreshData,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          var isLoadMore =
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent;
          if (isLoadMore) getData();
          return isLoadMore;
        },
        child: ListView.separated(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          itemCount: movies == null ? 0 : movies.length,
          itemBuilder: (context, position) {
            return GestureDetector(
              child: MovieCell(movies, position),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return new MovieDetailPage(movies[position]);
                }));
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
        ),
      ),
    );
  }

  Widget loadingWidget() {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  Widget errorWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(Images.ic_back_drop_holder),
        SizedBox(height: 5),
        Text("Ups something went wrong!"),
        SizedBox(height: 5),
        OutlinedButton(
          onPressed: getData,
          child: Text(
            "Refresh",
            style: TextStyle(color: UiConstants.PRIMARY_COLOR),
          ),
        )
      ],
    );
  }
}

