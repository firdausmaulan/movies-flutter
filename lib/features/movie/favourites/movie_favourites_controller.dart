import 'package:movies/data_manager/local/db_helper.dart';
import 'package:movies/model/movie.dart';

Future<List<Movie>> getMovies() async {
  DbHelper dbHelper = DbHelper();
  return dbHelper.getMovieList();
}