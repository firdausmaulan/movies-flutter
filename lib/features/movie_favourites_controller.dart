import 'package:movies/database/DBHelper.dart';
import 'package:movies/model/movie.dart';

Future<List<Movie>> getMovies() async {
  DbHelper dbHelper = DbHelper();
  return dbHelper.getMovieList();
}