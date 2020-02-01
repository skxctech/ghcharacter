import 'package:ghcharacter/enums/playableClass.dart';
import 'package:ghcharacter/models/brute.dart';
import 'package:ghcharacter/models/cragheart.dart';
import 'package:ghcharacter/models/mindthief.dart';
import 'package:ghcharacter/models/scoundrel.dart';
import 'package:ghcharacter/models/spellweaver.dart';
import 'package:ghcharacter/models/tinkerer.dart';

class CharacterHelper {
  static getCharacterDescription(PlayableClass playableClass) {
    switch (playableClass) {
      case PlayableClass.Brute:
        return Brute.description;
      case PlayableClass.Cragheart:
        return Cragheart.description;
      case PlayableClass.Mindthief:
        return Mindthief.description;
      case PlayableClass.Scoundrel:
        return Scoundrel.description;
      case PlayableClass.Spellweaver:
        return Spellweaver.description;
      case PlayableClass.Tinkerer:
        return Tinkerer.description;
    }
  }

  static getCharacterInstance(PlayableClass playableClass, dynamic data) {
    switch (playableClass) {
      case PlayableClass.Brute:
        return Brute.withId(
          data['id'],
          data['name'],
          xp: data['xp'],
          gold: data['gold'],
          battleGoals: data['battleGoals'],
          hitpoints: data['hitpoints'],
        );
      case PlayableClass.Cragheart:
        return Cragheart.withId(
          data['id'],
          data['name'],
          xp: data['xp'],
          gold: data['gold'],
          battleGoals: data['battleGoals'],
          hitpoints: data['hitpoints'],
        );
      case PlayableClass.Mindthief:
        return Mindthief.withId(
          data['id'],
          data['name'],
          xp: data['xp'],
          gold: data['gold'],
          battleGoals: data['battleGoals'],
          hitpoints: data['hitpoints'],
        );
      case PlayableClass.Scoundrel:
        return Scoundrel.withId(
          data['id'],
          data['name'],
          xp: data['xp'],
          gold: data['gold'],
          battleGoals: data['battleGoals'],
          hitpoints: data['hitpoints'],
        );
      case PlayableClass.Spellweaver:
        return Spellweaver.withId(
          data['id'],
          data['name'],
          xp: data['xp'],
          gold: data['gold'],
          battleGoals: data['battleGoals'],
          hitpoints: data['hitpoints'],
        );
      case PlayableClass.Tinkerer:
        return Tinkerer.withId(
          data['id'],
          data['name'],
          xp: data['xp'],
          gold: data['gold'],
          battleGoals: data['battleGoals'],
          hitpoints: data['hitpoints'],
        );
    }
  }
}
