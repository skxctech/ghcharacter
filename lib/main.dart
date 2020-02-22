import 'package:flutter/material.dart';
import 'package:ghcharacter/screens/start/start.dart';
import 'package:get_it/get_it.dart';
import 'package:ghcharacter/services/state.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<GHState>(GHState());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        accentColor: Colors.deepOrange,
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.white)
        )
      ),
      home: StartScreen(),
    );
  }
  
}