import 'package:flutter/material.dart';
import 'package:ghcharacter/utils/dbhelper.dart';
import 'package:ghcharacter/models/character.dart';

DbHelper dbHelper = DbHelper();

class CreateCharacter extends StatefulWidget {
  final String playableClass;
  CreateCharacter(this.playableClass);

  @override
  State<StatefulWidget> createState() => CreateCharacterState(playableClass);
}

class CreateCharacterState extends State {
  String playableClass;
  CreateCharacterState(this.playableClass);

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/${playableClass.toLowerCase()}.jpg'),
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
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsets.only(top: 150.0),
                          child: TextField(
                            controller: nameController,
                          )),
                      OutlineButton.icon(
                        icon: Icon(Icons.add),
                        textColor: Colors.white,
                        borderSide: BorderSide(color: Colors.white),
                        highlightedBorderColor: Colors.orangeAccent,
                        label: Text('Create Character'),
                        onPressed: () {
                          this.createCharacter(context);
                        },
                      ),
                    ]),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  createCharacter(ctx) {
    final char = Character(this.nameController.text, this.playableClass);

    dbHelper.insertCharacter(char).then((data) {
      Navigator.pop(ctx);
    });
  }
}
