import 'package:flutter/material.dart';
import 'package:movies/features/movie_detail.dart';
import 'package:movies/utils/constants.dart' as Constants;
import 'package:movies/utils/images.dart' as Images;
import 'package:movies/features/movie_list_controller.dart' as controller;

class MovieListPage extends StatefulWidget {
  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieListPage> {
  var showLoading = true;
  var showError = false;
  var movies;

  Future<void> getData() async {
    showLoading = true;
    var data = await controller.requestMovies();
    setState(() {
      showLoading = false;
      if (data != null) {
        showError = false;
        movies = data['results'];
      } else {
        showError = true;
      }
    });
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
        body: showLoading
            ? loadingWidget()
            : showError ? errorWidget() : mainWidget());
  }

  Widget mainWidget() {
    return RefreshIndicator(
      onRefresh: getData,
      child: ListView.separated(
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
        OutlineButton(
          onPressed: getData,
          child: Text(
            "Refresh",
            style: TextStyle(color: Constants.PRIMARY_COLOR),
          ),
        )
      ],
    );
  }
}

class MovieCell extends StatelessWidget {
  final movies;
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
          image: Constants.IMAGE_URL + movies[position]['poster_path'],
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
