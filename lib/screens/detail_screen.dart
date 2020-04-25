import 'package:belajar_carousel/controller/DBHelper.dart';
import 'package:belajar_carousel/model/FavoriteMovieModel.dart';
import 'package:belajar_carousel/screens/favorite_screen.dart';
import 'package:belajar_carousel/service/CrudOperation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final String idDetail;
  final String title;
  final String backdropPath;
  final String overview;
  final String releaseDate;
  final String originalLanguage;
  final String genreIds;
  final String keyTrailer;

  final FavoriteMovieModel favoriteMovie;
  final String isFavorite;

  DetailScreen({Key key, this.idDetail, this.title, this.backdropPath, this.overview, this.releaseDate, this.originalLanguage, this.genreIds, this.keyTrailer, this.favoriteMovie, this.isFavorite}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  FavoriteMovieModel favoriteMovie;

  _DetailScreenState();
  
  static String _idNya;
  String aaaa = _idNya;
  String urlTrailer;
  String urlDetail;
  int iiio = 0;

  //_id; _title; _poster; _backdropPath; _overview; _releaseDate; _originalLanguage;  _genreIds; _keyTrailer;

  Future addFavoriteMovie() async{
    var db = DBHelper();
    var favoriteMovie = FavoriteMovieModel(int.parse(widget.idDetail), widget.title.toString(), widget.backdropPath.toString(),
      widget.backdropPath.toString(), widget.overview.toString(), widget.releaseDate.toString(),
      widget.originalLanguage.toString(), widget.genreIds.toString(), widget.keyTrailer.toString()
    );
    await db.saveFavorite(favoriteMovie);
    print("addFavoriteMovie SAVED!");
  }

  void deleteFavorite(int favoriteMovieId) {
    var db = new DBHelper();
    db.deleteFavoriteMovie(favoriteMovieId);
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        color: Color.fromRGBO(0, 0, 26, 1),
        height: MediaQuery
            .of(context)
            .size
            .height * 1.5,
        child: Stack(
          children: <Widget>[
            Container(
                color: Color(0xFF070a6e),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 1,
//            height: MediaQuery.of(context).size.height * 1,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${widget.backdropPath.toString()}',
                  fit: BoxFit.fill,
                  repeat: ImageRepeat.repeatX,
                )
            ),
            Positioned(
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.6,
              child: Container(
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 1,
                    padding: EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 50.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color.fromRGBO(0, 0, 77, 0.85),
                              Color.fromRGBO(0, 0, 51, 0.95),
                              Color.fromRGBO(0, 0, 26, 1),
                            ]
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
//                          widget.title.toString(),
                        widget.title.toString(),
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Release date : ',
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100
                                ),
                              ),
                              Text(
                                widget.releaseDate.toString(),
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 30),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.red,
                                          Colors.pink,
                                          Colors.pinkAccent]
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.pinkAccent
                                ),
                                child: Text(
                                widget.genreIds.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(162, 162, 162, 0.2)
                                ),
                                child: Text(
                                  widget.originalLanguage.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Text(
                            widget.overview.toString(),
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white70
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.535,
              right: MediaQuery
                  .of(context)
                  .size
                  .width * 0.05,
              child: GestureDetector(
                onTap: () {
                  _launchURL(widget.keyTrailer.toString());
                },
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white54
                  ),
                  child: Icon(
                    Icons.play_circle_filled,
                    color: Colors.redAccent,
                    size: 80,
                  ),
                ),
              ),
            ),
            _buildBar(),
          ],
        ),
      ),
    );
  }


  _launchURL(String getKeyTrailer) async {
    String urlGetTrailer = 'https://www.youtube.com/watch?v=$getKeyTrailer';
    if (await canLaunch(urlGetTrailer)) {
      await launch(urlGetTrailer);
    } else {
      throw 'Could not launch $urlGetTrailer';
    }
  }

  static int favoriteAwal = 0;
  _buildBar() {
    favoriteAwal = int.parse(widget.isFavorite);
    print("favoriteAwal  ==> $favoriteAwal");
    print("AAASDAA _buildBar => $aaasdaa");
    if((aaasdaa%2) == 1){
      _favoriteIcon = new Icon(Icons.favorite, color: Colors.pink, size: 40);
    } else {
      _favoriteIcon  = new Icon(Icons.favorite_border, color: Colors.white70, size: 40,);
    }
//    aaasdaa = aaasdaa + 1;
    return Positioned(
        top: MediaQuery.of(context).size.height * 0.04,
        left: MediaQuery.of(context).size.width * 0.05,
        child: Row(
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteScreen()));
                  Navigator.pop(context);
                },
                child: Container(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white54,
                    size: 40,
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _favoritePressed,
                child: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.57,
                      right: 15
                  ),
                  child: _favoriteIcon,
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {

                },
                child: Container(
                  child: Icon(
                    Icons.share,
                    color: Colors.white70,
                    size: 40,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Icon _favoriteIcon;
  String wasFavorite = 'notfavorite';
  int aaasdaa = favoriteAwal;

  void _favoritePressed() {
    setState(() {
      aaasdaa = aaasdaa + 1;
      print("AAASDAA favoritePressed => $aaasdaa");
//      print("FAVORITE => ($aaasdaa) $wasFavorite ");
      if((aaasdaa%2) == 1) {
        _favoriteIcon = new Icon(
          Icons.favorite_border,
          color: Colors.white,
          size: 40,
        );
        addFavoriteMovie();
        Fluttertoast.showToast(
            msg: "BERHASIL SAVE FAVORITE!!",
            timeInSecForIos: 1,
            fontSize: 16.0,
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT
        );
        wasFavorite = 'favorite';
      } else {
        _favoriteIcon = new Icon(
          Icons.favorite,
          color: Colors.pink,
          size: 40,
        );
        deleteFavorite(int.parse(widget.idDetail));
        Fluttertoast.showToast(
            msg: "HAPUS DARI FAVORITE",
            timeInSecForIos: 1,
            fontSize: 16.0,
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT);

        wasFavorite = 'notfavorite';
      }

    });
  }



}
