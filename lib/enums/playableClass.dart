enum PlayableClass {
  Brute,
  Cragheart,
  Mindthief,
  Scoundrel,
  Spellweaver,
  Tinkerer
}

extension ParseToStringExt on PlayableClass {
  String toShortString() {
    return this.toString().split('.').last;
  }
}