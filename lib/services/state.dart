import 'package:rxdart/rxdart.dart';

// Global Variable 
GHState ghstateService = GHState();
class GHState {

  BehaviorSubject _level = BehaviorSubject.seeded(0);

  Stream get level$ => _level.stream;
  int get level => _level.value;

  setLevel(int level) { 
    _level.add(level);
  }

}