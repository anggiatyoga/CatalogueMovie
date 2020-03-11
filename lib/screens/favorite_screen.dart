import 'package:belajar_carousel/model/FavoriteMovieModel.dart';
import 'package:belajar_carousel/service/CrudOperation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  CrudOperation dbHelper = CrudOperation();
  Future<List<FavoriteMovieModel>> future;

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
        body: FutureBuilder<List<FavoriteMovieModel>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data.map((favoriteMovie) => cardList(favoriteMovie)).toList()
              );
            }else {
              return SizedBox();
            }
          },
        )
      ),
    );
  }

  Card cardList(FavoriteMovieModel favoriteMovie) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        leading: Image.network('https://image.tmdb.org/t/p/w185${favoriteMovie.poster.toString()}'),
        title: Text(favoriteMovie.title),
        onTap: () {
          Fluttertoast.showToast(
              msg: favoriteMovie.title,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            backgroundColor: Colors.pink,
            fontSize: 16.0,
            timeInSecForIos: 1
          );
        },
      )
    );
  }
}
