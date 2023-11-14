import 'package:flutter/material.dart';

import 'emojis.dart';

class Player {
  int id;
  Color color;
  Image emoji;

  Player({required this.id, required this.color, required this.emoji});

  static List<Player> generate(int playerCount) {
    List colors =
        new List.generate(playerCount, (i) => HSLColor.fromAHSL(1, 360 * i / playerCount, 0.7, 0.5).toColor());

    return new List.generate(playerCount, (i) => new Player(id: i, color: colors[i], emoji: Emojis.getSvg(i)));
  }
}
