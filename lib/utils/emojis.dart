import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Emojis {
  static getTransformedEmoji(Image emoji) {
    return Transform.translate(
      offset: const Offset(60.0, 0.0),
      child: Transform.rotate(
        child: Transform.scale(child: emoji, scale: 0.4),
        angle: -pi / 2,
      ),
    );
  }

  static getSvg(int index) {
    final emojis = [
      "assets/images/emoji/mouse.png",
      "assets/images/emoji/cow.png",
      "assets/images/emoji/elephant.png",
      "assets/images/emoji/turtle.png",
      "assets/images/emoji/chicken.png",
      "assets/images/emoji/pinguin.png",
      "assets/images/emoji/rabbit.png",
      "assets/images/emoji/cat.png",
      "assets/images/emoji/monkey.png",
      "assets/images/emoji/dog.png",
      "assets/images/emoji/pig.png",
      "assets/images/emoji/unicorn.png",
      "assets/images/emoji/duck.png",
      "assets/images/emoji/shark.png",
      "assets/images/emoji/dinosaur.png",
    ];

    return Image.asset(emojis[index % emojis.length]);
  }
}
