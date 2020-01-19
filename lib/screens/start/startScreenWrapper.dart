import 'package:flutter/material.dart';

class StartScreenWrapper extends StatelessWidget {

  final String title;
  final String subtitle;
  StartScreenWrapper(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontFamily: 'PirataOne',
              fontSize: 30,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 4.0,
                  color: Colors.black,
                  offset: Offset(1.0, 1.0),
                ),
              ]),
        ),
        Padding(
          padding: EdgeInsets.only(top: 7.0),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                color: Colors.white.withOpacity(0.3),
                height: 1.0,
              )),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Text(
                  subtitle.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.5),
                    letterSpacing: 5,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                color: Colors.white.withOpacity(0.3),
                height: 1.0,
              ))
            ],
          ),
        ),
      ],
    );
  }
}