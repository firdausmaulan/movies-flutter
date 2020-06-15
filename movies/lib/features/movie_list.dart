import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/utils/constants.dart' as Constants;
import 'package:movies/utils/images.dart' as Images;

class MovieListPage extends StatefulWidget {
  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieListPage> {
  var movies;

  Future<Map> requestMovies() async {
    var url = Constants.BASE_URL +
        "/movie/top_rated?" +
        "&api_key=${Constants.API_KEY}";
    var response = await http.get(url);
    return json.decode(response.body);
  }

  void getData() async {
    var data = await requestMovies();
    setState(() {
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        appBar: AppBar(
          title: Text(Constants.APP_NAME),
        ),
        body: ListView.separated(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          itemCount: movies == null ? 0 : movies.length,
          itemBuilder: (context, position) {
            return GestureDetector(
              child: MovieCell(movies, position),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
        ));
  }
}

class MovieCell extends StatelessWidget {
  final movies;
  final position;

  MovieCell(this.movies, this.position);

  @override
  Widget build(BuildContext context) {
    //80% of screen width
    double c_width = MediaQuery.of(context).size.width * 0.75;
    return Row(
      children: <Widget>[
        FadeInImage.assetNetwork(
          placeholder: Images.ic_question,
          image: Constants.IMAGE_URL + movies[position]['poster_path'],
          width: 75,
          height: 100,
        ),
        Container(
          padding: EdgeInsets.all(4),
          width: c_width,
          height: 110,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movies[position]['title'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                movies[position]['overview'],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                "Rating : ${movies[position]['vote_average']}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.orange),
              )
            ],
          ),
        ),
      ],
    );
  }
}
