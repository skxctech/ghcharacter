import 'package:ghcharacter/models/character.dart';

class Brute extends Character {

  int hitpoints;
  int xp;
  int gold;
  int battleGoals;

  // fugly generation, but worth it to init custom stats per class
  Brute(
    String name,
    {
      this.xp: 0,
      this.gold: 0,
      this.battleGoals: 0,
      this.hitpoints: 0
    }
  ) : super(
      name, 
      'Brute', 
      hitpoints: hitpoints,
      xp: xp, 
      gold: gold,
      xpBase: 45, 
      levelUpDifficulty: 5, 
      battleGoals: battleGoals
  );

  Brute.withId(
    int id,
    String name,
    {
      this.xp: 0,
      this.gold: 0,
      this.battleGoals: 0,
      this.hitpoints: 0
    }
  ) : super.withId(
      id, 
      name, 
      'Brute', 
      xp: xp, 
      gold: gold,
      hitpoints: hitpoints,
      xpBase: 45, 
      levelUpDifficulty: 5, 
      battleGoals: battleGoals
  );

  int get maxHp {
    if (this.level == 1) {
      return 10;
    } else {
      return 8 + this.level * 2;
    }
  }

  // TODO handle this logic after building
  // attack modifier deck logic
  List<String> perks = [
    'Remove two -1 cards',
    'Replace one -1 card with one + 1 card',
    'Add two +1 cards',
    'Add two +1 cards',
    'Add one +3 card',
    'Add three PUSH 1 cards',
    'Add three PUSH 1 cards',
    'Add two PIERCE 3 cards',
    'Add one STUN card',
    'Add one STUN card',
    'Add one DISARM card and one MUDDLE card',
    'Add one ADD TARGET card',
    'Add one ADD TARGET card',
    'Add one +1 Shield 1, Self card',
    'Ignore negative item effects and add one +1 card'
  ];

}