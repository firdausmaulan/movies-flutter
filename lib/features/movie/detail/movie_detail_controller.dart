import 'package:movies/data_manager/local/db_helper.dart';
import 'package:movies/model/movie.dart';

Future<bool> getFavourite(Movie movie) async {
  DbHelper dbHelper = DbHelper();
  bool isFavourite = await dbHelper.isFavourite(movie.id) == 1;
  return isFavourite;
}


Future<bool> setFavourite(Movie movie) async {
  DbHelper dbHelper = DbHelper();
  bool isExist = await dbHelper.isFavourite(movie.id) == 1;
  if (isExist) {
    dbHelper.delete(movie.id);
  } else {
    dbHelper.insert(movie);
  }
  return !isExist;
}