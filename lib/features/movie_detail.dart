import 'package:flutter/material.dart';
import 'package:movies/features/movie_detail_controller.dart' as controller;
import 'package:movies/model/movie.dart';
import 'package:movies/utils/constants.dart' as Constants;
import 'package:movies/utils/images.dart' as Images;

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage(this.movie);

  @override
  MovieDetailState createState() => MovieDetailState(movie);
}

class MovieDetailState extends State<MovieDetailPage> {
  final Movie movie;

  MovieDetailState(this.movie);

  bool isFavourite = false;
  IconData iconFavourite = Icons.favorite_border;

  Future<void> getFavourite() async {
    isFavourite = await controller.getFavourite(movie);
    setState(() {
      if (isFavourite) {
        iconFavourite = Icons.favorite;
      } else {
        iconFavourite = Icons.favorite_border;
      }
    });
  }

  Future<void> updateFavourite() async {
    isFavourite = await controller.setFavourite(movie);
    setState(() {
      if (isFavourite) {
        iconFavourite = Icons.favorite;
      } else {
        iconFavourite = Icons.favorite_border;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getFavourite();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 30,
            color: Constants.PRIMARY_COLOR,
          ),
          Stack(
            children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: Images.ic_back_drop_holder,
                image: Constants.IMAGE_URL + movie.backdrop_path.toString(),
                width: screenWidth,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  padding: EdgeInsets.all(8),
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: EdgeInsets.all(8),
                  icon: Icon(iconFavourite, color: Colors.yellow),
                  onPressed: () {
                    updateFavourite();
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                      placeholder: Images.ic_poster_holder,
                      image: Constants.IMAGE_URL + movie.poster_path.toString(),
                      height: 100,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("ID : ${movie.id}"),
                          SizedBox(height: 4),
                          Text("Language : ${movie.original_language}"),
                          SizedBox(height: 4),
                          Text("Rating : ${movie.vote_average}"),
                          SizedBox(height: 4),
                          Text("Vote Count : ${movie.vote_count}"),
                          SizedBox(height: 4),
                          Text("Popularity : ${movie.popularity}"),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  movie.overview,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
