import 'package:flutter/material.dart';
import 'package:ghcharacter/screens/start/start.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        accentColor: Colors.deepOrange
      ),
      home: StartScreen(),
    );
  }
  
}