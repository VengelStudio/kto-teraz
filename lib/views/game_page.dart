import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class GamePage extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<GamePage> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final items = <String>[
      'Grogu',
      'Mace Windu',
      'Obi-Wan Kenobi',
      'Han Solo',
      'Luke Skywalker',
      'Darth Vader',
      'Yoda',
      'Ahsoka Tano',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Fortune Wheel'),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            selected = Random().nextInt(items.length);
          });
        },
        child: Column(
          children: [
            Expanded(
              child: FortuneWheel(
                selected: selected,
                items: [
                  for (var it in items) FortuneItem(child: Text(it)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}