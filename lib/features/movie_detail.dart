import 'package:flutter/material.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/utils/constants.dart' as Constants;
import 'package:movies/utils/images.dart' as Images;

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

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
                image: Constants.IMAGE_URL + movie.backdrop_path,
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
                      image: Constants.IMAGE_URL + movie.poster_path,
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
