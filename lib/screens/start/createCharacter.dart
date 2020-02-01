import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ghcharacter/screens/character/character.dart';
import 'package:ghcharacter/utils/dbhelper.dart';
import 'package:ghcharacter/models/character.dart';
import 'package:ghcharacter/helpers/character.helper.dart';
import 'package:ghcharacter/enums/playableClass.dart';

DbHelper dbHelper = DbHelper();

class CreateCharacter extends StatefulWidget {
  final PlayableClass playableClass;
  CreateCharacter(this.playableClass);

  @override
  State<StatefulWidget> createState() => CreateCharacterState(playableClass);
}

class CreateCharacterState extends State {
  PlayableClass playableClass;
  CreateCharacterState(this.playableClass);

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => scopePop(),
      child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/images/${playableClass.toShortString().toLowerCase()}.jpg'),
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
                  children: [
                    Hero(
                      tag: 'logoHero',
                      child: Container(
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Hero(
                              tag: 'characterHeader',
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        'assets/icons/classes/${playableClass.toShortString().toLowerCase()}.svg',
                                        color: Colors.white.withOpacity(0.5),
                                        width: 50,
                                        height: 50,
                                      ),
                                      Expanded(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: TextField(
                                            textInputAction:
                                                TextInputAction.done,
                                            onSubmitted: (term) =>
                                                createCharacter(),
                                            autofocus: true,
                                            cursorColor: Colors.white,
                                            textAlign: TextAlign.center,
                                            decoration:
                                                InputDecoration.collapsed(
                                              hintText: 'Tap to set name',
                                              hintStyle: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.5)),
                                            ),
                                            controller: nameController,
                                            style: TextStyle(
                                                fontFamily: 'PirataOne',
                                                fontSize: 30,
                                                color: Colors.white,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white
                                                    .withOpacity(0.3)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50.0))),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.5),
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
                                        padding: EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Text(
                                            this.playableClass.toShortString().toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: 'RobotoCondensed',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color:
                                                  Colors.white.withOpacity(0.5),
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
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        left: 20,
                                        right: 20,
                                        bottom: 20),
                                    child: Text(
                                      CharacterHelper.getCharacterDescription(this.playableClass),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'HighTower',
                                        fontSize: 18,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                  // OutlineButton.icon(
                                  //   icon: Icon(Icons.add),
                                  //   textColor: Colors.white,
                                  //   borderSide: BorderSide(color: Colors.white),
                                  //   highlightedBorderColor: Colors.orangeAccent,
                                  //   label: Text('Create Character'),
                                  //   onPressed: () {
                                  //     this.createCharacter();
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  scopePop() {
    Navigator.pop(this.context, false);
  }

  createCharacter() {
    if (this.nameController.text.length > 0) {
      final char = Character(this.nameController.text, this.playableClass.toShortString());

      dbHelper.insertCharacter(char).then((id) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterScreen(
              id,
              this.playableClass,
              this.nameController.text,
            ),
          ),
        );
      });
    } else {
      this.alertNameMissing();
    }
  }

  Future<bool> alertNameMissing() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You need to name your character'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
