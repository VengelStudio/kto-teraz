import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Emojis {
  static getTransformedEmoji(SvgPicture emoji) {
    return Transform.translate(
      offset: const Offset(60.0, 0.0),
      child: Transform.rotate(
        child: Transform.scale(child: emoji, scale: 0.8),
        angle: -pi / 2,
      ),
    );
  }

  static getSvg(int index) {
    final emojis = [
      "assets/images/emoji/mouse.svg",
      "assets/images/emoji/cow.svg",
      "assets/images/emoji/elephant.svg",
      "assets/images/emoji/turtle.svg",
      "assets/images/emoji/chicken.svg",
      "assets/images/emoji/pinguin.svg",
      "assets/images/emoji/rabbit.svg",
      "assets/images/emoji/cat.svg",
      "assets/images/emoji/monkey.svg",
      "assets/images/emoji/dog.svg",
      "assets/images/emoji/pig.svg",
      "assets/images/emoji/unicorn.svg",
      "assets/images/emoji/duck.svg",
      "assets/images/emoji/shark.svg",
      "assets/images/emoji/dinosaur.svg",
    ];

    return SvgPicture.asset(emojis[index % emojis.length]);
  }
}
