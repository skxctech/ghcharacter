import 'package:flutter/material.dart';
import 'package:ghcharacter/enums/playableClass.dart';
import 'package:ghcharacter/models/character.dart';
import 'package:ghcharacter/screens/characterDetail.dart';
import 'package:ghcharacter/utils/dbhelper.dart';

class CharacterList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CharacterListState();
}

class CharacterListState extends State {
  DbHelper dbHelper = DbHelper();

  int count = 0;
  List<Character> characters;

  @override
  Widget build(BuildContext context) {

    debugPrint('build from charList called ' + DateTime.now().toString());

    if (characters == null) {
      characters = List<Character>();
      getData();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Character List')),
      body: characterListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Character('', 'Brute', 0, 0));
        },
        tooltip: "Create character",
        child: new Icon(Icons.add),
      ),
    );
  }

  ListView characterListItems() {
    return ListView.builder(
        itemCount: this.count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.lightGreen, child: Text('1')),
                title: Text(this.characters[position].name),
                subtitle: Text(
                    this.characters[position].playableClass.toShortString()),
                onTap: () {
                  navigateToDetail(this.characters[position]);
                }),
          );
        });
  }

  void getData() {
    final dbFuture = dbHelper.initializeDb();
    dbFuture.then((result) {
      final charactersFuture = dbHelper.getCharacters();
      charactersFuture.then((result) {
        List<Character> characterList = List<Character>();
        this.count = result.length;
        for (int i = 0; i < count; i++) {
          characterList.add(Character.fromObject(result[i]));
        }
        setState(() {
          this.characters = characterList;
          this.count = count;
        });
      });
    });
  }

  void navigateToDetail(Character character) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => CharacterDetail(character)));
    if (result == true) {
      getData();
    }
  }
}
