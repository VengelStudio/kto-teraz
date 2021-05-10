import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'emojis.dart';

class Player {
  int id;
  Color color;
  SvgPicture emoji;

  Player({int id, Color color, SvgPicture emoji}) {
    this.id = id;
    this.color = color;
    this.emoji = emoji;
  }

  static List<Player> generate(int playerCount) {
    List colors = new List.generate(playerCount,
        (i) => HSLColor.fromAHSL(1, 360 * i / playerCount, 0.7, 0.5).toColor());

    return new List.generate(playerCount,
        (i) => new Player(id: i, color: colors[i], emoji: Emojis.getSvg(i)));
  }
}
