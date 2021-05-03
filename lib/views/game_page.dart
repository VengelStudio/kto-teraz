import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class GamePage extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class PlayerSlice {
  String text;

  Color color;

  PlayerSlice(String text) {
    this.text = text;
    this.color = getColor();
  }

  static Random random = new Random();

  static Color getColor() {
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}

class _GameState extends State<GamePage> {
  int selected = 0;
  int nextDurationInS = 4;

  @override
  Widget build(BuildContext context) {
    final items = <PlayerSlice>[
      new PlayerSlice("Bartek"),
      new PlayerSlice("Lukasz"),
      new PlayerSlice("Bartek"),
      new PlayerSlice("Lukasz"),
      new PlayerSlice("Bartek"),
      new PlayerSlice("Lukasz"),
    ];

    return Scaffold(
      body: GestureDetector(
        child: Column(
          children: [
            Expanded(
              child: FortuneWheel(
                physics: CircularPanPhysics(
                  duration: Duration(seconds: nextDurationInS),
                  curve: Curves.ease,
                ),
                onFling: () {
                  setState(() {
                    nextDurationInS = Random().nextInt(4) + 1;
                    selected = Random().nextInt(items.length);
                  });
                },
                selected: selected,
                items: [
                  for (var it in items)
                    FortuneItem(
                      child: Text(it.text),
                      style: FortuneItemStyle(
                        color: it.color, // <-- custom circle slice fill color
                        borderColor: Colors
                            .green, // <-- custom circle slice stroke color
                        borderWidth: 3, // <-- custom circle slice stroke width
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
