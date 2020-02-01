import 'package:flutter/material.dart';
import 'package:ghcharacter/models/character.dart';

class HitpointManager extends StatefulWidget {
  final Character character;

  HitpointManager(this.character);

  @override
  State<StatefulWidget> createState() => HitpointManagerState(character);
}

class HitpointManagerState extends State {
  Character character;

  HitpointManagerState(this.character);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Health',
                    style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      this.hitpoints,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '/',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      this.maxHp,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    )
                  ],
                )
              ],
            ),
            FractionallySizedBox(
              widthFactor: 1.0,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 10,
                color: Colors.red.shade900,
                child: FractionallySizedBox(
                  widthFactor: this.hpPercentage,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 10,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    color: Colors.red,
                    tooltip: 'Remove hitpoint',
                    onPressed: this.removeHitpoint,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    color: Colors.red,
                    tooltip: 'Add hitpoint',
                    onPressed: this.addHitpoint,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String get hitpoints {
    return this.character.hitpoints.toString();
  }

  String get maxHp {
    return this.character.maxHp.toString();
  }

  double get hpPercentage {
    return this.character.hitpoints / this.character.maxHp;
  }

  addHitpoint() {
    if (this.character.hitpoints < this.character.maxHp) {
      setState(() {
        this.character.hitpoints++;
      });
    }
  }

  removeHitpoint() {
    if (this.character.hitpoints > 0) {
      setState(() {
        this.character.hitpoints--;
      });
    }
  }
}
