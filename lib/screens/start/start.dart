import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ghcharacter/models/character.dart';
import 'package:ghcharacter/screens/start/createCharacter.dart';
import 'package:ghcharacter/screens/start/startScreenWrapper.dart';
import 'package:ghcharacter/utils/dbhelper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghcharacter/enums/playableClass.dart';

DbHelper dbHelper = DbHelper();

class StartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartScreenState();
}

class StartScreenState extends State {
  bool newUser = true;

  String bgUrl = 'assets/images/box-art-cropped.jpg';

  int count = 0;
  List<Character> characters = [];

  final pageViewController = PageController(initialPage: 0);

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
                  Hero(
                    tag: 'logoHero',
                    child: Container(
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: this.pageViewController,
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      children: <Widget>[
                        this.renderCharacterCreation(),
                        Column(children: [
                          Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: StartScreenWrapper(
                                'Your Characters', 'Were where we?'),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: this.count,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/classes/${this.characters[index].playableClass.toShortString().toLowerCase()}.svg'),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                this.characters[index].name,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'RobotoCondensed',
                                                    color: Colors.white,
                                                    fontSize: 22),
                                              ),
                                              Text(
                                                'Level ${this.characters[index].level.toString()} ${this.characters[index].playableClass.toShortString()}',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    color: Colors.white
                                                        .withOpacity(0.75),
                                                    fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Center(
                                          child: Ink(
                                            child: IconButton(
                                              icon: Icon(Icons.delete),
                                              color: Colors.white,
                                              onPressed: () {
                                                this.deleteCharacter(
                                                    this.characters[index],
                                                    index);
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.keyboard_arrow_left,
                                color: Colors.white.withOpacity(0.5),
                                size: 18,
                              ),
                              Text(
                                'create new character',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ],
                          )
                        ]),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  init() {
    dbHelper.getCharacters().then((characterList) {
      this.initialized = true;
      if (characterList.length > 0) {
        this.newUser = false;
        this.getCharacters();
      }
    });
  }

  getCharacters() {
    dbHelper.getCharacters().then((characterList) {
      if (characterList.length > 0) {
        setState(() {
          this.count = characterList.length;
          this.characters = characterList.map((characterData) {
            return Character.fromObject(characterData);
          }).toList();
        });
        this.pageViewController.animateToPage(1,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
  }

  renderCharacterCreation() {
    List<String> playableClasses = [
      'Brute',
      'Cragheart',
      'Mindthief',
      'Scoundrel',
      'Spellweaver',
      'Tinkerer'
    ];

    List<Widget> createCharacterWidget = playableClasses.map((className) {
      return Material(
        color: Colors.black.withOpacity(0),
        child: InkWell(
          onTap: () {
            this.openCreateScreen(className);
          },
          highlightColor: Colors.deepOrange,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                SvgPicture.asset(
                    'assets/icons/classes/${className.toLowerCase()}.svg'),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        className,
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            color: Colors.white,
                            fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();

    List<Widget> creationList = [
      Padding(
        padding: EdgeInsets.only(top: 40),
        child: Hero(
          tag: 'createHero',
          child: StartScreenWrapper('Create Character', 'Pick a class'),
        ),
      ),
      Expanded(child: ListView(children: createCharacterWidget)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'your characters',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right,
            color: Colors.white.withOpacity(0.5),
            size: 18,
          )
        ],
      )
    ];

    final content = Column(children: creationList);

    return content;
  }

  deleteCharacter(Character character, int index) async {
    if (await this.confirmDelete(character)) {
      dbHelper.deleteCharacter(character.id).then((res) {
        this.getCharacters();
      });
    }
  }

  openCreateScreen(String className) async {
    final res = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreateCharacter(className)));

    if (res) {
      this.getCharacters();
    }
  }

  Future<bool> confirmDelete(Character character) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to delete this character?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    '${character.name} the ${character.playableClass.toShortString()} will be gone.')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            )
          ],
        );
      },
    );
  }
}
