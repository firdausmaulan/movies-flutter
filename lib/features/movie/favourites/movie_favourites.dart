import 'package:flutter/material.dart';
import 'package:movies/customwidgets/cells/movie_cell.dart';
import 'package:movies/features/movie/detail/movie_detail.dart';
import 'package:movies/features/movie/favourites/movie_favourites_controller.dart' as controller;
import 'package:movies/model/movie.dart';
import 'package:movies/utils/constants.dart' as Constants;

class MovieFavouritesPage extends StatefulWidget {
  @override
  MovieFavouritesState createState() => MovieFavouritesState();
}

class MovieFavouritesState extends State<MovieFavouritesPage> {
  List<Movie> movies = [];

  Future<void> getData() async {
    var data = await controller.getMovies();
    setState(() {
      movies.addAll(data);
    });
  }

  Future<void> refreshData() async {
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
        ),
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              var isLoadMore = scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent;
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
        )
    );
  }
}
