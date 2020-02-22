import 'package:flutter/material.dart';
import 'package:ghcharacter/models/character.dart';
import 'package:get_it/get_it.dart';
import 'package:ghcharacter/services/state.dart';

GetIt getIt = GetIt.instance;

class ExperienceManager extends StatefulWidget {
  final Character character;

  ExperienceManager(this.character);

  @override
  State<StatefulWidget> createState() => ExperienceManagerState(character);
}

class ExperienceManagerState extends State {

  final ghStateService = getIt.get<GHState>();

  Character character;

  ExperienceManagerState(this.character);

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
                    'Experience',
                    style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      this.xp,
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
                      this.xpStep,
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
                color: Colors.blue.shade900,
                child: FractionallySizedBox(
                  widthFactor: this.xpPercentage,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 10,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlineButton.icon(
                    icon: Icon(Icons.add_circle_outline),
                    textColor: Colors.blue,
                    borderSide: BorderSide(color: Colors.blue),
                    highlightedBorderColor: Colors.blueAccent,
                    label: Text(
                      'Add Experience',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: this.updateXp,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String get xp {
    return this.character.xp.toString();
  }

  String get xpStep {
    return this.character.xpStep.toString();
  }

  double get xpPercentage {
    return this.character.xp / this.character.xpStep;
  }

  updateXp() {
    setState(() {
      this.character.xp += 5;
    });
    ghStateService.setLevel(this.character.level);
  }
}
