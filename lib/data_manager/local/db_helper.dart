import 'package:movies/model/movie.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

//needed for async process
import 'dart:io';

//needed for accessing file & directory on device
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {
    //set database name & location / path
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'movie.db';
    // create & versioning database
    var database = openDatabase(path, version: 1, onCreate: _createDb);
    return database;
  }

  //create new table
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movie (
        id INTEGER PRIMARY KEY,
        title TEXT,
        original_title TEXT,
        overview TEXT,
        popularity REAL,
        vote_count INTEGER,
        poster_path TEXT,
        backdrop_path TEXT,
        original_language TEXT,
        vote_average REAL,
        release_date TEXT
      )
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('movie', orderBy: 'id');
    return mapList;
  }

  Future<List<Map<String, dynamic>>> findById(int id) async {
    Database db = await this.database;
    var mapList = await db.query('movie',
        // Ensure that has a matching id.
        where: "id = ?",
        // Pass id as a whereArg to prevent SQL injection.
        whereArgs: [id]);
    return mapList;
  }

//create databases
  Future<int> insert(Movie object) async {
    Database db = await this.database;
    int count = await db.insert('movie', object.toJson());
    return count;
  }

//update databases
  Future<int> update(Movie object) async {
    Database db = await this.database;
    int count = await db.update('movie', object.toJson(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('movie', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Movie>> getMovieList() async {
    var movieMapList = await select();
    int count = movieMapList.length;
    List<Movie> movieList = <Movie>[];
    for (int i = 0; i < count; i++) {
      movieList.add(Movie.fromJson(movieMapList[i]));
    }
    return movieList;
  }

  Future<int> isFavourite(int id) async {
    var movie = await findById(id);
    return movie.length;
  }
}
