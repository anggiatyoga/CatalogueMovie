import 'package:sqflite/sqlite_api.dart';
import 'package:belajar_carousel/model/FavoriteMovieModel.dart';
import 'package:belajar_carousel/controller/DBHelper.dart';

class CrudOperation {
  static const favoriteMovieTable = 'favoriteMovie';
  static const id = 'id';
  static const title = 'title';
  static const poster = 'poster';
  static const backdropPath = 'backdropPath';
  static const overview = 'overview';
  static const releaseDate = 'releaseDate';
  static const originalLanguage = 'originalLanguage';
  static const genreIds = 'genreIds';
  static const keyTrailer = 'keyTrailer';

  DBHelper dbHelper = new DBHelper();

  //CREATE
  Future<int> insert(FavoriteMovieModel favoriteMovie) async {
    Database db = await dbHelper.setDB();
    final sql = ''' INSERT INTO ${CrudOperation.favoriteMovieTable}
    (
      ${CrudOperation.id},
      ${CrudOperation.title},
      ${CrudOperation.poster},
      ${CrudOperation.backdropPath},
      ${CrudOperation.overview},
      ${CrudOperation.releaseDate},
      ${CrudOperation.originalLanguage},
      ${CrudOperation.genreIds},
      ${CrudOperation.keyTrailer}
    )
    VALUES (?,?,?,?,?,?,?,?,?)''';
    List<dynamic> params = [favoriteMovie.id, favoriteMovie.title, favoriteMovie.poster, favoriteMovie.backdropPath,
    favoriteMovie.overview, favoriteMovie.releaseDate, favoriteMovie.originalLanguage, favoriteMovie.genreIds,
    favoriteMovie.keyTrailer];
    final result = await db.rawInsert(sql, params);
    return result;
  }

  //UPDATE
//  Future<int> update(FavoriteMovieModel favoriteMovie) async {
//    Database db = await dbHelper.setDB();
//    final sql = '''UPDATE ${CrudOperation.favoriteMovieTable} SET
//    ${CrudOperation.title} = ?, ${CrudOperation.poster}
//    WHERE ${CrudOperation.id} = ? ''';
//    List<dynamic> params = [favoriteMovie.id, favoriteMovie.title, favoriteMovie.poster];
//    final result = await db.rawUpdate(sql, params);
//    return result;
//  }

  //DElETE
Future<int> delete(FavoriteMovieModel favoriteMovie) async {
    Database db = await dbHelper.setDB();
    final sql = '''DELETE FROM ${CrudOperation.favoriteMovieTable}
    WHERE ${CrudOperation.id} = ? ''';

    List<dynamic> params = [CrudOperation.id];
    final result = await db.rawDelete(sql, params);
    return result;
}

//READ ALL
Future<List<FavoriteMovieModel>> getFavoriteMovieList() async {
    Database db = await dbHelper.setDB();
    final sql = '''SELECT * FROM ${CrudOperation.favoriteMovieTable}''';
    final data = await db.rawQuery(sql);
    List<FavoriteMovieModel> favoriteMovies = List();

    for(final node in data) {
      final favoriteMovie = FavoriteMovieModel.map(node);
      favoriteMovies.add(favoriteMovie);
    }
    return favoriteMovies;
}

}