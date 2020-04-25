import 'dart:io' as io;
import 'dart:async';
import 'package:belajar_carousel/model/FavoriteMovieModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DBHelper{
  static final DBHelper _instance = new DBHelper.internal();
  DBHelper.internal();

  factory DBHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if(_db != null) return _db;
    _db = await setDB();
    return _db;
  }

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path , "favoriteMovie.db");
    var favoriteMovieDB = await openDatabase(path, version: 1, onCreate: _createDb);
    return favoriteMovieDB;
  }
//  id, title, poster, backdropPath, overview, releaseDate, originalLanguage, genreIds, keyTrailer
  void _createDb(Database db, int version) async {
    await db.execute("CREATE TABLE favoriteMovie (id INTEGER PRIMARY KEY,title TEXT,poster TEXT,"
        "backdropPath TEXT, overview TEXT, releaseDate TEXT, originalLanguage TEXT, genreIds TEXT,"
        "keyTrailer TEXT)");
    print("DB Created");
  }

  Future<int> saveFavorite(FavoriteMovieModel favoriteMovieModel) async {
    var dbClient = await db;
    int res = await dbClient.insert("favoriteMovie", favoriteMovieModel.toMap());
    print("data inserted");
    return res;
  }

  Future<List<FavoriteMovieModel>> getFavoriteMovie() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM favoriteMovie");
    List<FavoriteMovieModel> favoriteMovieData = new List();
    for(int i=0; i<list.length; i++){
      var favorite = new FavoriteMovieModel(list[i]["_id"], list[i]["_title"], list[i]["_poster"],
          list[i]["_backdropPath"], list[i]["_overview"], list[i]["_releaseDate"],
          list[i]["_originalLanguage"], list[i]["_genreIds"], list[i]["_keyTrailer"]);
      favoriteMovieData.add(favorite);
    }
    return favoriteMovieData;
  }

  Future<int> deleteFavoriteMovie(int favoriteMovieID) async {
    var dbClient =await db;
    int res = await dbClient.rawDelete("DELETE FROM favoriteMovie WHERE id = ?", [favoriteMovieID]);
    return res;
  }

//    Future<Database> initDb() async {
//      io.Directory directory = await getApplicationDocumentsDirectory();
//      String path = directory.path + 'favoriteMovie.db';
//      var favoriteMovieDatabase = openDatabase(path, version: 1, onCreate: _createDb);
//      return favoriteMovieDatabase;
//    }




}