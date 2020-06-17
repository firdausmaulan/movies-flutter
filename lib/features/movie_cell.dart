import 'package:flutter/material.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/utils/constants.dart' as Constants;
import 'package:movies/utils/images.dart' as Images;

class MovieCell extends StatelessWidget {
  final List<Movie> movies;
  final position;

  MovieCell(this.movies, this.position);

  @override
  Widget build(BuildContext context) {
    //80% of screen width
    double containerWidth = MediaQuery.of(context).size.width - 90;
    return Row(
      children: <Widget>[
        FadeInImage.assetNetwork(
          placeholder: Images.ic_poster_holder,
          image: Constants.IMAGE_URL + movies.elementAt(position).poster_path.toString(),
          height: 100,
          width: 75,
        ),
        Container(
          width: containerWidth,
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movies.elementAt(position).title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                movies.elementAt(position).overview,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                "Rating : ${movies.elementAt(position).vote_average}",
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