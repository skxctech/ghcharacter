import 'package:ghcharacter/enums/playableClass.dart';

class Character {
  int id;
  String name;
  PlayableClass playableClass;
  int hitpoints;
  int xp;
  int gold;
  int xpBase = 45;
  int levelUpDifficulty = 5;
  int battleGoals = 0;
  int initiative = 0;

  Character(
    this.name, 
    String _playableClass, 
    {
      this.hitpoints,
      this.xp: 0,
      this.gold: 0,
      this.xpBase, 
      this.levelUpDifficulty,
      this.battleGoals,
      this.initiative
    }
  ) { 
    playableClass = getPlayableClass(_playableClass);
    this.hitpoints = this.maxHp;
  }

  Character.withId(
    this.id,
    this.name, 
    String _playableClass, 
    {
      this.hitpoints,
      this.xp: 0,
      this.gold: 0,
      this.xpBase, 
      this.levelUpDifficulty,
      this.battleGoals,
      this.initiative
    }
  ) { 
    this.playableClass = getPlayableClass(_playableClass);
    if (this.hitpoints == null) {
      this.hitpoints = this.maxHp;
    }
  }

  Character.fromObject(dynamic o) {
    this.id = o["id"];
    this.name = o["name"];
    this.playableClass = getPlayableClass(o["playableClass"]);
    // TODO remove safety checks once DB structure is stable
    if (o["xp"] != null) {
      this.xp = o["xp"];
    }
    if (o["gold"] != null) {
      this.gold = o["gold"];
    }
    if (o["battleGoals"] != null) {
      this.battleGoals = o["battleGoals"];
    }
    if (o["levelUpDifficulty"] != null) {
      this.levelUpDifficulty = o["levelUpDifficulty"];
    }
    if (o["xpBase"] != null) {
      this.xpBase = o["xpBase"];
    }
    if (o["hitpoints"] != null) {
      this.hitpoints = o["hitpoints"];
    }
    if (o["initiative"] != null) {
      this.initiative = o["initiative"];
    }
  }

  addGold(int amountToAdd) {
    this.gold += amountToAdd;
  }

  int get level {
    num baseDifficulty = 0;
    num level = 0;
    num xpSum = 0;

    if (this.xp == 0) {
      return 1;
    }

    while (xpSum <= this.xp) {
      xpSum += xpBase + baseDifficulty;
      baseDifficulty += this.levelUpDifficulty;
      level++;
    }

    return level;
  }

  int get xpStep {
    num baseDifficulty = 0;
    num xpSum = 0;

    while (xpSum <= this.xp) {
      xpSum += xpBase + baseDifficulty;
      baseDifficulty += this.levelUpDifficulty;
    }

    return xpSum;
  }

  
  int get maxHp {
    // TODO change formula to work per class
    if (this.level == 1) {
      return 10;
    } else {
      return 8 + this.level * 2;
    }
  }

  String get icon {
    return 'someAssetUrl' + this.playableClass.toShortString();
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