import 'package:flutter/material.dart';
import 'package:ghcharacter/models/character.dart';
import 'package:ghcharacter/enums/playableClass.dart';
import 'package:ghcharacter/utils/dbhelper.dart';

DbHelper dbHelper = DbHelper();

final List<String> appMenuItems = const <String> [
  'Delete Character',
];

class CharacterDetail extends StatefulWidget {

  final Character character;
  CharacterDetail(this.character);

  @override
  State<StatefulWidget> createState() => CharacterDetailState(character);
}

class CharacterDetailState extends State {
  Character character;
  CharacterDetailState(this.character);

  // check what this value outputs
  final List<String> _playableClasses = PlayableClass.values.map((playableClass) {
    return playableClass.toShortString();
  }).toList();

  String _activePlayableClass;

  TextEditingController nameController = TextEditingController();
  TextEditingController xpController = TextEditingController();
  TextEditingController goldController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    nameController.text = character.name;
    xpController.text = character.xp.toString();
    goldController.text = character.gold.toString();
    _activePlayableClass = character.playableClass.toShortString();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(character.name),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: selectMenuItem,
            itemBuilder: (BuildContext context) {
              return appMenuItems.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice)
                );
              }).toList();
            }
          )
        ]
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nameController,
              onChanged: (value) => this.updateName(),
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
            ),
            TextField(
              controller: xpController,
              keyboardType: TextInputType.number,
              onChanged: (value) => this.updateXp(),
              decoration: InputDecoration(
                labelText: "Experience",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
            ),
            TextField(
              controller: goldController,
              keyboardType: TextInputType.number,
              onChanged: (value) => this.updateGold(),
              decoration: InputDecoration(
                labelText: "Gold",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0)
                )
              ),
            ),
            DropdownButton<String>(
              items: _playableClasses.map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              value: _activePlayableClass,
              onChanged: (value) => this.updatePlayableClass(value),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this.save();
        },
        tooltip: "Create character",
        child: new Icon(Icons.check),
      ),
      
    );

  }

  selectMenuItem(String value) {
    if (value == 'Delete Character') {
      if (character.id != null) {
        dbHelper.deleteCharacter(character.id);  
      }
      Navigator.pop(context, true);
    }
  }

  updateName() {
    character.name = nameController.text;
  }
  updateXp() {
    character.xp = int.parse(xpController.text);
  }
  updateGold() {
   character.gold = int.parse(goldController.text);
  }
  updatePlayableClass(String value) {
    setState(() {
      this._activePlayableClass = value;
      character.playableClass = Character.getPlayableClass(value);
    });
  }

  void save() {
    if (character.id != null) {
      dbHelper.updateCharacter(character);
    } else {
      dbHelper.insertCharacter(character);
    }
    Navigator.pop(context, true);
  }
  
}