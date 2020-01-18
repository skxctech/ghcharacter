import 'package:flutter/material.dart';
import 'package:ghcharacter/models/character.dart';
import 'package:ghcharacter/utils/dbhelper.dart';

DbHelper dbHelper = DbHelper();

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Future<List> _count = dbHelper.getCharacters();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tinkerer.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.overlay,
            ),
          ),
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
                    child: FutureBuilder<List> (
                      future: _count,
                      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

                        Widget row = Text('loading...'); 

                        if(snapshot.hasData) {
                          if(snapshot.data.length > 0) {
                            row = this.getCharactersList(snapshot.data);
                          } else {
                            row = this.getCreationList();
                          }
                        }

                        return row;
                      }
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

  getCharactersList(data) {
    
    List<Character> characterList = data.map<Character>(
      (characterData) => Character.fromObject(characterData)
    ).toList();

    return new Row(children: characterList.map<Widget>((character) => 
      new Text(character.name)
    ).toList());

  }
  getCreationList() {

    return Text('well');

  }
}