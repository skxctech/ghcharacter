import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghcharacter/helpers/character.helper.dart';
import 'package:ghcharacter/screens/character/experienceManager.dart';
import 'package:ghcharacter/screens/character/hitpointManager.dart';
import 'package:ghcharacter/utils/dbhelper.dart';
import 'package:ghcharacter/models/character.dart';
import 'package:ghcharacter/enums/playableClass.dart';

DbHelper dbHelper = DbHelper();

class CharacterScreen extends StatefulWidget {
  final int characterId;
  final PlayableClass playableClass;
  final String name;
  CharacterScreen(this.characterId, this.playableClass, this.name);

  @override
  State<StatefulWidget> createState() =>
      CharacterScreenState(characterId, playableClass, name);
}

class CharacterScreenState extends State {
  final int characterId;
  final PlayableClass playableClass;
  final String name;
  CharacterScreenState(this.characterId, this.playableClass, this.name);

  Character character;

  bool initialized = false;

  get backgroundUrl {
    return 'assets/images/${playableClass.toShortString().toLowerCase()}.jpg';
  }

  get iconUrl {
    return 'assets/icons/classes/${playableClass.toShortString().toLowerCase()}.svg';
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      this.getData();
    }

    //return WillPopScope(

    return WillPopScope(
      onWillPop: () => scopePop(),
      child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.33),
              BlendMode.overlay,
            ),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.9],
                colors: [
                  Colors.black.withOpacity(0.25),
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
              child: Column(children: [
                Hero(
                  tag: 'characterHeader',
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SvgPicture.asset(
                            iconUrl,
                            color: Colors.white.withOpacity(0.5),
                            width: 50,
                            height: 50,
                          ),
                          Expanded(
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: 'PirataOne',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.3)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0))),
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                this.character.level.toString(),
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontFamily: 'RobotoCondensed',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            color: Colors.white.withOpacity(0.3),
                            height: 1.0,
                          )),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                playableClass.toShortString().toUpperCase(),
                                style: TextStyle(
                                  fontFamily: 'RobotoCondensed',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.5),
                                  letterSpacing: 8,
                                ),
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
                    ],
                  ),
                ),
                if (this.character != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    HitpointManager(this.character),
                    ExperienceManager(this.character),
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  getData() {
    this.initialized = true;
    dbHelper.getCharacter(this.characterId).then((characterData) {
      setState(() {
        this.character = CharacterHelper.getCharacterInstance(
            this.playableClass, characterData[0]);
      });
    });
  }

  scopePop() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }
}
