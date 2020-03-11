import 'package:belajar_carousel/screens/casoursel_screen.dart';
import 'package:belajar_carousel/screens/listview_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListViewScreens(),
    );
  }
}