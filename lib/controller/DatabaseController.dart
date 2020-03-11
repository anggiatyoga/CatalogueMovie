import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController{

  //Future<Database> get database async {}

    Future<Database> initDb() async {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = directory.path + 'favoriteMovie.db';
      var favoriteMovieDatabase = openDatabase(path, version: 1, onCreate: _createDb);
      return favoriteMovieDatabase;
    }

    void _createDb(Database db, int version) async {
      await db.execute('''
      CREATE TABLE favoriteMovie (
        id INTEGER PRIMARY KEY,
        title TEXT,
        poster TEXT 
      )
      ''');
    }

}