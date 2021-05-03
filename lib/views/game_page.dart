import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_spinner/utils/emojis.utils.dart';
import 'package:flutter_svg/svg.dart';

class GamePage extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class PlayerSlice {
  int id;
  Color color;
  SvgPicture emoji;

  PlayerSlice(int id, Color color, SvgPicture emoji) {
    this.id = id;
    this.color = color;
    this.emoji = emoji;
  }

  static getEmojiSvg(int index) {
    // todo shuffle

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

  static List<PlayerSlice> generate(int howMany) {
    List colors = new List.generate(howMany,
        (i) => HSLColor.fromAHSL(1, 360 * i / howMany, 0.7, 0.5).toColor());

    return new List.generate(
        howMany, (i) => new PlayerSlice(i, colors[i], getEmojiSvg(i)));
  }
}

class _GameState extends State<GamePage> {
  int selectedPlayerIndex = 0;
  int nextDurationInS = 4;

  int tempPlayerCount = 15;

  @override
  Widget build(BuildContext context) {
    final players = PlayerSlice.generate(tempPlayerCount);

    final wheelIndicator = FortuneIndicator(
      alignment: Alignment.topCenter,
      child: Transform.translate(
        child: new TriangleIndicator(color: const Color(0xff2f2f2f)),
        offset: const Offset(0, -11),
      ),
    );

    spinWheel() {
      setState(() {
        nextDurationInS = Random().nextInt(4) + 1;
        selectedPlayerIndex = Random().nextInt(players.length);
      });
    }

    // todo temporary dialog, remove this when implementing question popup
    showAlertDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        content: Text("Index won: $selectedPlayerIndex"),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    openQuestion() {
      // todo temporary dialog, remove this when implementing question popup
      showAlertDialog(context);
    }

    return Scaffold(
      body: GestureDetector(
        child: Column(
          children: [
            Expanded(
                child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: PhysicalShape(
                      color: Colors.transparent,
                      shadowColor: Colors.black,
                      elevation: 8,
                      clipper: ShapeBorderClipper(shape: CircleBorder()),
                      child: FortuneWheel(
                        physics: CircularPanPhysics(
                          duration: Duration(seconds: nextDurationInS),
                          curve: Curves.ease,
                        ),
                        onFling: spinWheel,
                        onAnimationEnd: openQuestion,
                        animateFirst: false,
                        selected: selectedPlayerIndex,
                        indicators: <FortuneIndicator>[wheelIndicator],
                        items: [
                          for (var player in players)
                            FortuneItem(
                              child: Emojis.getTransformedEmoji(player.emoji),
                              style: FortuneItemStyle(
                                color: player
                                    .color, // <-- custom circle slice fill color
                                borderColor: Colors
                                    .black38, // <-- custom circle slice stroke color
                                borderWidth:
                                    1, // <-- custom circle slice stroke width
                              ),
                            ),
                        ],
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
