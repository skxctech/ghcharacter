import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ghcharacter/models/character.dart';
import 'package:ghcharacter/utils/dbhelper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghcharacter/enums/playableClass.dart';

DbHelper dbHelper = DbHelper();

class StartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartScreenState();
}

class StartScreenState extends State {
  String bgUrl = 'assets/images/box-art-cropped.jpg';

  String screenTitle = '';
  String screenSubtitle = '';

  AnimationController controller;

  Widget content = Center(
      child: Icon(
    Icons.loop,
    color: Colors.white,
    size: 24.0,
    semanticLabel: 'Loading...',
  ));

  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      this.init();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(this.bgUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.33),
              BlendMode.overlay,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.9],
              colors: [
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0.66),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 30.0,
              right: 20.0,
              left: 20.0,
              bottom: 20.0,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsets.only(top: 60),
                          child: startScreenWrapper(
                              this.screenTitle, this.screenSubtitle)),
                      Expanded(child: this.content)
                    ]),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  init() {
    dbHelper.getCharacters().then((characterList) {
      if (characterList.length > 0) {
        // set screen pick
        final characters = characterList.map((characterData) {
          final character = Character.fromObject(characterData);

          final classIconUrl =
              'assets/icons/classes/${character.playableClass.toShortString().toLowerCase()}.svg';

          return Dismissible(
            key: Key(character.id.toString()),
            onDismissed: this.dismissCharacter,
            child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                SvgPicture.asset(classIconUrl),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        character.name,
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            color: Colors.white,
                            fontSize: 22),
                      ),
                      Text(
                        'Level ${character.level.toString()} ${character.playableClass.toShortString()}',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white.withOpacity(0.75),
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),);
        }).toList();
        
        final ListView charactersList = ListView(children: characters);

        final yourCharactersWidget = Column(
          children: [
            Expanded(child: charactersList),
            OutlineButton.icon(
              icon: Icon(Icons.add_circle),
              textColor: Colors.white,
              borderSide: BorderSide(color: Colors.white),
              highlightedBorderColor: Colors.orangeAccent,
              label: Text('New Character'),
              onPressed: () {},
            )
          ],
        );

        this.initialized = true;
        setState(() {
          this.screenTitle = 'Your Characters';
          this.screenSubtitle = 'Where were we?';
          this.content = yourCharactersWidget;
        });
      } else {
        // set screen to creation
      }
    });
  }

  startScreenWrapper(String title, String subtitle) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontFamily: 'PirataOne',
              fontSize: 30,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 4.0,
                  color: Colors.black,
                  offset: Offset(1.0, 1.0),
                ),
              ]),
        ),
        Padding(
          padding: EdgeInsets.only(top: 7.0),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                color: Colors.white.withOpacity(0.3),
                height: 1.0,
              )),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Text(
                  subtitle.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.5),
                    letterSpacing: 5,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                color: Colors.white.withOpacity(0.3),
                height: 1.0,
              ))
            ],
          ),
        ),
      ],
    );
  }

  dismissCharacter(direction) {

  }

}
