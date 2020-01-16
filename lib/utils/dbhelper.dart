import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:ghcharacter/models/character.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();

  String tblCharacter = "character";
  String colId = 'id';
  String colName = 'name';
  String colPlayableClass = 'playableClass';
  String colXp = 'xp';
  String colGold = 'gold';
  String colXpBase = 'xpBase';
  String colLevelUpDifficulty = 'levelUpDifficulty';
  String colBattleGoals = 'battleGoals';
  String colInitiative = 'initiative';

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'characters.db';
    var dbCharacters = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbCharacters;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE $tblCharacter(" + 
      "$colId INTEGER PRIMARY KEY," + 
      "$colName TEXT," + 
      "$colPlayableClass INTEGER, " + 
      "$colXp INTEGER, " + 
      "$colGold INTEGER, " + 
      "$colXpBase INTEGER, " +
      "$colLevelUpDifficulty INTEGER, " +
      "$colBattleGoals INTEGER, " +
      "$colInitiative INTEGER" +
    ")");
  }

  Future<int> insertCharacter(Character character) async {
    Database db = await this.db;
    var result = await db.insert(tblCharacter, character.toMap());
    return result;
  }

  
  Future<int> updateCharacter(Character character) async {
    var db = await this.db;
    var result = await db.update(
      tblCharacter, 
      character.toMap(), 
      where: "$colId = ?", 
      whereArgs: [character.id]
    );
    return result;
  }

  Future<List> getCharacters() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblCharacter order by $colName ASC");
    return result;
  }

  Future<int> deleteCharacter(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete("DELETE FROM $tblCharacter WHERE $colId = $id");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
      await db.rawQuery("select count (*) from $tblCharacter")
    );
    return result;
  }

}