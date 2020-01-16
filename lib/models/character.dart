import 'package:ghcharacter/enums/playableClass.dart';

class Character {
  int id;
  String name;
  PlayableClass playableClass;
  int hitpoints;
  int xp;
  int gold;
  int xpBase;
  int levelUpDifficulty;
  int battleGoals;
  int initiative;

  Character(
    this.name, 
    String _playableClass, 
    {
      this.hitpoints: 0,
      this.xp: 0,
      this.gold: 0,
      this.xpBase: 45, 
      this.levelUpDifficulty: 5,
      this.battleGoals: 0,
      this.initiative: 0
    }
  ) { playableClass = getPlayableClass(_playableClass); }

  Character.withId(
    this.id,
    this.name, 
    String _playableClass, 
    {
      this.hitpoints: 0,
      this.xp: 0,
      this.gold: 0,
      this.xpBase: 45, 
      this.levelUpDifficulty: 5,
      this.battleGoals: 0
    }
  ) { playableClass = getPlayableClass(_playableClass); }

  Character.fromObject(dynamic o) {
    this.id = o["id"];
    this.name = o["name"];
    this.playableClass = getPlayableClass(o["playableClass"]);
    this.xp = o["xp"];
    this.gold = o["gold"];
    this.battleGoals = o["battleGoals"];
  }

  addGold(int amountToAdd) {
    this.gold += amountToAdd;
  }

  int get level {
    num baseDifficulty = 0;
    num level = 0;
    num xpSum = 0;

    while (xpSum <= this.xp) {
      xpSum += xpBase + baseDifficulty;
      baseDifficulty += this.levelUpDifficulty;
      level++;
    }

    return level;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['playableClass'] = playableClass.toShortString();
    map['xp'] = xp;
    map['gold'] = gold;
    map['xpBase'] = xpBase;
    map['levelUpDifficulty'] = levelUpDifficulty;
    map['battleGoals'] = battleGoals;
    map['initiative'] = initiative;
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // stupid?
  static PlayableClass getPlayableClass(String pcName) {
    switch(pcName) {
      case 'Brute':
        return PlayableClass.Brute;
        break;
      case 'Cragheart':
        return PlayableClass.Cragheart;
        break;
      case 'Mindthief':
        return PlayableClass.Mindthief;
        break;
      case 'Scoundrel':
        return PlayableClass.Scoundrel;
        break;
      case 'Spellweaver':
        return PlayableClass.Spellweaver;
        break;
      case 'Tinkerer':
        return PlayableClass.Tinkerer;
        break;
      
      default:
        throw (pcName.toString() + ' is not matching any class in PlayableClass');
        break;
    }
  }
}