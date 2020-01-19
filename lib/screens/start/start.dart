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

  List charactersData;

  final pageViewController = PageController(initialPage: 0);

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
                  Hero(
                    tag: 'logoHero',
                    child: Container(
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  Expanded(flex: 2, child: this.content),
                ]),
          ),
        ),
      ),
    );
  }

  init() {
    dbHelper.getCharacters().then((characterList) {
      this.initialized = true;

      List<Widget> widgets = [];

      if (characterList.length > 0) {
        this.charactersData = characterList;
        this.newUser = false;
        widgets.add(this.renderCharacterSelection());
      }
      widgets.add(this.renderCharacterCreation());

      final pageView = PageView(
            controller: this.pageViewController,
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            children: widgets);

      setState(() {
        this.content = pageView;
      });
    });
  }

  renderCharacterSelection() {
    final characters = this.charactersData.map<Widget>((characterData) {
      final character = Character.fromObject(characterData);

      final classIconUrl =
          'assets/icons/classes/${character.playableClass.toShortString().toLowerCase()}.svg';

      return Dismissible(
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red.withOpacity(0.5),
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Icon(Icons.delete, color: Colors.white, size: 30.0)],
            ),
          ),
        ),
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
        ),
      );
    }).toList();

    final ListView charactersList = ListView(children: characters);

    final yourCharactersWidget = Column(
      children: [
        Expanded(child: charactersList),
        OutlineButton.icon(
          icon: Icon(Icons.arrow_forward),
          textColor: Colors.white,
          borderSide: BorderSide(color: Colors.white),
          highlightedBorderColor: Colors.orangeAccent,
          label: Text('New Character'),
          onPressed: () {
            this.pageViewController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);
          },
        )
      ],
    );

    final content = Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 40),
        child: StartScreenWrapper('Your Characters', 'Were where we?'),
      ),
      Expanded(child: yourCharactersWidget)
    ]);

    return content;
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

    final content = Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 40),
        child: StartScreenWrapper('Pick a class', 'No pressure'),
      ),
      Expanded(child: ListView(children: createCharacterWidget)),
      this.getOptionalButton()
    ]);

    return content;
  }

  getOptionalButton() {
    if (!newUser) {
      return OutlineButton.icon(
        icon: Icon(Icons.arrow_back),
        textColor: Colors.white,
        borderSide: BorderSide(color: Colors.white),
        highlightedBorderColor: Colors.orangeAccent,
        label: Text('Manage Characters'),
        onPressed: () {
          this.pageViewController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
      );
    }
  }

  dismissCharacter(direction) {}

  openCreateScreen(String className) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CreateCharacter(className)));
  }
}
