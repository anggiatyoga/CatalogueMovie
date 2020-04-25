
import 'package:belajar_carousel/model/FavoriteMovieModel.dart';
import 'package:belajar_carousel/screens/detail_screen.dart';
import 'package:belajar_carousel/service/CrudOperation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteScreen extends StatefulWidget {
  final int id;
  final String title;
  final String poster;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final String originalLanguage;
  final String genreIds;
  final String keyTrailer;

  const FavoriteScreen({Key key, this.id, this.title, this.poster, this.backdropPath, this.overview, this.releaseDate, this.originalLanguage, this.genreIds, this.keyTrailer}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  CrudOperation dbHelper = CrudOperation();
  Future<List<FavoriteMovieModel>> future;
  final String isFavorite = '3';

  @override
  void initState() {
    updateListFavorite();
    super.initState();
  }

  void updateListFavorite() {
    setState(() {
      future = dbHelper.getFavoriteMovieList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xFF000428),
                      Color(0xFF0012b3),
                      Color(0xFF3347ff),
                      Color(0xFF004e92)
                    ]
                )
            ),
          ),
          centerTitle: true,
          title: Text('Favorite Movie'),
        ),
        body: Container(
          child: FutureBuilder<List<FavoriteMovieModel>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: snapshot.data.map((favoriteMovie) => cardList(favoriteMovie)).toList()
                    ),
                  ),
                );
              }else {
                return SizedBox();
              }
            },
          ),
        )
      ),
    );
  }

  GestureDetector cardList(FavoriteMovieModel favoriteMovie) {
//    print("ID     => ${favoriteMovie.id.toString()}");
//    print("TITLE  => ${favoriteMovie.title.toString()}");
//    print("POSTER => ${favoriteMovie.poster.toString()}");
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                  idDetail: favoriteMovie.id.toString(),
                  title: favoriteMovie.title.toString(),
                  backdropPath: favoriteMovie.poster.toString(),
                  overview: favoriteMovie.overview.toString(),
                  releaseDate: favoriteMovie.releaseDate.toString(),
                  genreIds: favoriteMovie.genreIds.toString(),
                  originalLanguage: favoriteMovie.originalLanguage.toString(),
                  keyTrailer: favoriteMovie.keyTrailer.toString(),
                  isFavorite: isFavorite,
                )
            )
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        color: Colors.pinkAccent,
        elevation: 2.0,
        margin: EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: <Widget>[
              Image.network(
                  'https://image.tmdb.org/t/p/w185${favoriteMovie.poster.toString()}',
                fit: BoxFit.cover,
                width: 300,
                height: 150,
              ),
              Container(
                width: 300,
                height: 150,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.black.withAlpha(0),
                      Colors.black54,
                      Colors.black87
                    ],
                  ),
                ),
                child: Text(
                  favoriteMovie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 25.0),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

//ListTile(
//leading: Image.network('https://image.tmdb.org/t/p/w185${favoriteMovie.poster.toString()}'),
//title: Text(favoriteMovie.title),
//onTap: () {
//Fluttertoast.showToast(
//msg: favoriteMovie.title,
//toastLength: Toast.LENGTH_SHORT,
//gravity: ToastGravity.CENTER,
//textColor: Colors.white,
//backgroundColor: Colors.pink,
//fontSize: 16.0,
//timeInSecForIos: 1
//);
//},
//)