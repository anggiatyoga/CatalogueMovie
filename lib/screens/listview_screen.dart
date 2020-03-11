import 'package:belajar_carousel/screens/detail_screen.dart';
import 'package:belajar_carousel/screens/favorite_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListViewScreens extends StatefulWidget {
  @override
  _ListViewScreensState createState() => _ListViewScreensState();
}

class _ListViewScreensState extends State<ListViewScreens> {
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();

  String _searchText = "";
  List dataMovie = new List();
  List namesMovie = new List();
  List namesSearchMovie = new List();
  List filteredDataMovie = new List();
  List filteredSearchMovie = new List();
  List filteredFinal = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Icon _launchIcon = new Icon(Icons.launch);
  Widget _appBarTitle = new Text('Search Example');

  _ListViewScreensState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredDataMovie = namesMovie;
          filteredFinal = filteredDataMovie;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          filteredSearchMovie = namesSearchMovie;
          filteredFinal = filteredSearchMovie;
        });
      }
    });
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: InputDecoration(
            icon: IconButton(icon: Icon(Icons.launch), color: Colors.greenAccent,
                onPressed: () {
                  _getData();
                }
            ),
            hintText: 'Search movie...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search Example');
        filteredSearchMovie = namesSearchMovie;
        _filter.clear();
      }
    });
  }

  void _getData() async {
    String queryTitle = _searchText.toString();

    String urlSearchList = 'https://api.themoviedb.org/3/search/movie?api_key=b3d55b9965fe7810605834ceed8a62ed&language=en-US&query=$queryTitle&page=1&include_adult=false';
    String urlDefaultList = 'https://api.themoviedb.org/3/discover/movie?api_key=b3d55b9965fe7810605834ceed8a62ed';
    print("QUERY TITLE => $queryTitle");

    if(queryTitle.isEmpty || queryTitle=="") {
      final _response = await dio.get(urlDefaultList);
      List tempDefault = new List();
      for (int i = 0; i < _response.data['results'].length; i++) {
        tempDefault.add(_response.data['results'][i]);
      }
      setState(() {
        namesMovie = tempDefault;
        filteredDataMovie = namesMovie;
      });
    }
    else {
      final _response = await dio.get(urlSearchList);
      List tempSearchList = new List();
      for(int i = 0; i < _response.data['results'].length; i++) {
        tempSearchList.add(_response.data['results'][i]);
      }
      setState(() {
        namesSearchMovie = tempSearchList;
        filteredSearchMovie = namesSearchMovie;
      });
    }

  }

  @override
  void initState() {
    super.initState();
    this._getData();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Latihan",
      home: Scaffold(
        appBar: _buildBar(context),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.4,
                0.6,
                0.9
              ],
              colors: [
                Colors.blueAccent,
                Colors.deepPurple,
                Colors.indigo,
                Colors.teal
              ]
            )
          ),
          child: Column(
            children: <Widget>[
              Flexible(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.all(25.0),
                    child: Text(
                      "Hello World!",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                flex: 1,
              ),
              Flexible(
                flex: 4,
                child: Container(
                  child: _buildList(),
                ),
              ),
              Flexible(
                child: Container(
                  color: Colors.transparent,
                ),
                flex: 1,
              )
            ],
          ),
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: IconButton(icon: _searchIcon, onPressed: _searchPressed),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.favorite, color: Colors.pink,), onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteScreen()));
        })
      ],
    );
  }

  Widget _buildList() {
    List tempList = new List();
    if(!(_searchText.isEmpty)) {
      print("SEARCH TEXT ===> $_searchText");

      for(int i = 0; i < filteredSearchMovie.length; i++) {
        if (filteredSearchMovie[i]['title'].toLowerCase().contains(_searchText.toLowerCase())) {
            tempList.add(filteredSearchMovie[i]);
        }
      }

    } else {
      filteredFinal = filteredDataMovie;
    }

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: namesMovie == null ? 0 : filteredFinal.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        idDetail: filteredFinal[index]['id'].toString(),
                          title: filteredFinal[index]['title'].toString(),
                          backdropPath: filteredFinal[index]['poster_path'].toString(),
                          overview: filteredFinal[index]['overview'].toString(),
                          releaseDate: filteredFinal[index]['release_date'].toString(),
//                          genreIds: filteredFinal[index]['genres'][0]['name'],
                          originalLanguage: filteredFinal[index]['original_language'],
//                          keyTrailer: filteredFinal[index]['results'][0]['key'].toString()
                      )
                  )
              );
            },
            child: Card(
              elevation: 20,
              color: Color(0xFFebebed),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(children: <Widget>[
                    Image.network(
                      'https://image.tmdb.org/t/p/w185${filteredFinal[index]['poster_path']}',
                      fit: BoxFit.fill,
                      width: 250,
                      height: 500,
                    ),
                    Container(
                      width: 250,
                      padding: EdgeInsets.all(30.0),
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
                        filteredFinal[index]['title'].toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white, fontSize: 25.0),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          );
        }
        );
  }

}
