import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';

class CarouselScreen extends StatefulWidget {
  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  int index = 1;
  final String url =       
  "https://api.themoviedb.org/3/discover/movie?api_key=b3d55b9965fe7810605834ceed8a62ed";
  List dataMovie;

  Future<String> getData() async {
    var res = await http.get(Uri.encodeFull(url), headers: {'accept': 'application/json'});

    setState(() {
      var content = json.decode(res.body);
      dataMovie = content['results'];
    });
    return 'success';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Carousell",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Carousel"),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Spacer(),
            CarouselSlider(
              height: 400.0,
              items: dataMovie[index]['results'].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage("https://image.tmdb.org/t/p/w185//uPGq1mkEXznUpapDmOSxbsybjfp.jpg"), fit: BoxFit.cover),
                            color: Colors.amber),
                        // child: Text("https://image.tmdb.org/t/p/w185/$i")
                        );
                  },
                );
              }).toList(),
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            Spacer()
          ],
        )),
      ),
    );
  }
}