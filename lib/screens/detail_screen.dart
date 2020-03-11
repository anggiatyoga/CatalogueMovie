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

  final FavoriteMovieModel favoriteMovie;

  DetailScreen({Key key, this.idDetail, this.title, this.backdropPath, this.overview, this.releaseDate, this.originalLanguage, this.favoriteMovie}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState(this.favoriteMovie);
}

class _DetailScreenState extends State<DetailScreen> {
  FavoriteMovieModel favoriteMovie;

  _DetailScreenState(this.favoriteMovie);
  
  static String _idNya;
  String aaaa = _idNya;
  String urlTrailer;
  String urlDetail;


  String genreIds;
  String keyTrailer;

  Icon _favoriteIcon = new Icon(Icons.favorite_border, color: Colors.white70, size: 40,);

  Future<String> getDataDetail(String ididid) async {
    urlTrailer = 'http://api.themoviedb.org/3/movie/$ididid/videos?api_key=b3d55b9965fe7810605834ceed8a62ed';
    urlDetail = 'https://api.themoviedb.org/3/movie/$ididid?api_key=b3d55b9965fe7810605834ceed8a62ed&language=en-US';

    try{
      var res = await http.get(Uri.encodeFull(urlDetail),
          headers: {'accept': 'application/json'});

      var resTrailer = await http.get(Uri.encodeFull(urlTrailer),
          headers: {'accept':'application/json'});
      setState(() {
        var content = json.decode(res.body);
        var contentTrailer = json.decode(resTrailer.body);

        genreIds = content['genres'][0]['name'];
        keyTrailer = contentTrailer['results'][0]['key'].toString();

      });
    } catch(e) {
      print("================");
      print(e);
      print("================");
    }

    return 'Succes!';
  }

//  @override
//  void initState() {
//    super.initState();
//    this.getDataDetail();
//  }

  @override
  Widget build(BuildContext context) {

  getDataDetail(widget.idDetail.toString());

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
                                genreIds.toString(),
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
                  _launchURL(keyTrailer.toString());
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

  _buildBar() {
    return Positioned(
        top: MediaQuery.of(context).size.height * 0.04,
        left: MediaQuery.of(context).size.width * 0.05,
        child: Row(
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
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

  void _favoritePressed() {
    CrudOperation dbHelper = new CrudOperation();
    setState(() {
      if(favoriteMovie == null) {
        this._favoriteIcon = new Icon(
            Icons.favorite,
          color: Colors.pink,
          size: 40,
        );
        try{
          favoriteMovie = FavoriteMovieModel(int.parse(widget.idDetail), widget.title.toString(), widget.backdropPath.toString());
//        dbHelper.insert(favoriteMovie);
          Fluttertoast.showToast(
              msg: "ATAS SUCSES SAVE!!",
              timeInSecForIos: 1,
              fontSize: 16.0,
              backgroundColor: Colors.pink,
              textColor: Colors.white,
              gravity: ToastGravity.CENTER,
              toastLength: Toast.LENGTH_SHORT);
        } catch (error) {
          Fluttertoast.showToast(
              msg: "ATAS GAGAL SAVE!!",
              timeInSecForIos: 1,
              fontSize: 16.0,
              backgroundColor: Colors.pink,
              textColor: Colors.white,
              gravity: ToastGravity.CENTER,
              toastLength: Toast.LENGTH_SHORT);
        }

      } else {
        this._favoriteIcon = new Icon(
            Icons.favorite_border,
          color: Colors.white,
          size: 40,
        );
        Fluttertoast.showToast(
            msg: "GAGAL SAVE!!",
            timeInSecForIos: 1,
            fontSize: 16.0,
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT);
        favoriteMovie.id = int.parse(widget.idDetail);
        favoriteMovie.title = widget.title.toString();
        favoriteMovie.poster = widget.backdropPath.toString();
      }
    });
  }
}
