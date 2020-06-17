import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies/features/movie_cell.dart';
import 'package:movies/features/movie_detail.dart';
import 'package:movies/features/movie_search_controller.dart' as controller;
import 'package:movies/model/movie.dart';

class MovieSearchPage extends StatefulWidget {
  @override
  MovieSearchState createState() => MovieSearchState();
}

class MovieSearchState extends State<MovieSearchPage> {
  List<Movie> movies = [];
  final TextEditingController searchController = TextEditingController();
  Timer debounceTimer;

  MovieSearchState() {
    searchController.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }
      debounceTimer = Timer(Duration(milliseconds: 500), () {
        if (this.mounted) {
          performSearch(searchController.text);
        }
      });
    });
  }

  Future<void> performSearch(String query) async {
    var data = await controller.searchMovies(query);
    setState(() {
      if (data != null) {
        var result = data['results'];
        movies.clear();
        for (Map i in result) {
          movies.add(Movie.fromJson(i));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
          autofocus: true,
          controller: searchController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search movies...",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 4, bottom: 4),
        itemCount: movies == null ? 0 : movies.length,
        itemBuilder: (context, position) {
          return GestureDetector(
            child: MovieCell(movies, position),
            onTap: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new MovieDetailPage(movies[position]);
              }));
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}
