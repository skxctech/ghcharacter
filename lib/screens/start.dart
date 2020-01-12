import 'package:flutter/material.dart';
import 'package:ghcharacter/models/character.dart';
import 'package:ghcharacter/screens/characterDetail.dart';
import 'package:ghcharacter/screens/characterList.dart';
import 'package:ghcharacter/utils/dbhelper.dart';

DbHelper dbHelper = DbHelper();

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/tinkerer.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.overlay)),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Image.asset('assets/images/logo.png'),
                Text(
                  'Character Manager',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PirataOne',
                    fontSize: 40.0,
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 100.0),
                  child: Center(
                    child: OutlineButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CharacterList()),
                        );
                      },
                      borderSide: BorderSide(color: Colors.white),
                      icon: Icon(
                        Icons.add,
                        color: Colors.white
                      ),
                      label: Text('Create character', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
