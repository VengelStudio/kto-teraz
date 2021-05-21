import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_spinner/utils/winner.model.dart';
import 'package:flutter_spinner/widgets/question_card.dart';
import 'package:flutter_spinner/utils/emojis.dart';
import 'package:flutter_spinner/utils/options.model.dart';
import 'package:flutter_spinner/utils/players.dart';
import 'package:flutter_spinner/utils/questions.dart';

class GamePage extends StatefulWidget {
  final GameOptions gameOptions;

  const GamePage(this.gameOptions);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<GamePage> {
  int nextDurationInS = 4;
  QuestionManager questionManager;
  Winner winner = new Winner();

  _loadQuestions() async {
    var createdManager =
        await QuestionManager.create(context, widget.gameOptions.isTabuEnabled);

    setState(() {
      questionManager = createdManager;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    final players = Player.generate(widget.gameOptions.numberOfPeople);

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

        int winnerId = Random().nextInt(players.length);
        winner.id = winnerId;
        winner.color = players[winnerId].color;
        winner.emoji = players[winnerId].emoji;
      });
    }

    openQuestion() {
      Navigator.push(
        context,
        _questionCardRoute(
          winner,
          questionManager,
        ),
      );
      print(winner);
    }

    return Scaffold(
      body: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: questionManager != null
                      ? PhysicalShape(
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
                            selected: winner.id == null ? 0 : winner.id,
                            indicators: <FortuneIndicator>[wheelIndicator],
                            items: [
                              for (var player in players)
                                FortuneItem(
                                  child:
                                      Emojis.getTransformedEmoji(player.emoji),
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
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(Color(0xffD30C7B)),
                            ),
                            SizedBox(height: 20.0),
                            Text("Ładowanie...")
                          ],
                        )),
            ),
          ],
        ),
      ),
    );
  }
}

Route _questionCardRoute(winner, questionManager) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        QuestionCard(winner: winner, question: questionManager.next()),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
