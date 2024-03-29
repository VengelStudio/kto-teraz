import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import '../utils/collection.dart';
import '../utils/winner.model.dart';
import '../widgets/question_card.dart';
import '../utils/emojis.dart';
import '../utils/options.model.dart';
import '../utils/players.dart';
import '../utils/question.dart';

class GamePage extends StatefulWidget {
  final GameOptions gameOptions;
  final List<Collection> collections;

  const GamePage({required this.gameOptions, required this.collections});

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<GamePage> {
  int nextDurationInS = 4;
  QuestionManager? questionManager;
  Winner? winner;
  var controller = StreamController<int>();
  bool isInstructionVisible = true;

  List<Player> players = [];
  List<FortuneItem> fortuneWheelItems = [];

  final wheelIndicator = FortuneIndicator(
    alignment: Alignment.topCenter,
    child: Transform.translate(
      child: new TriangleIndicator(color: const Color(0xff2f2f2f)),
      offset: const Offset(0, -11),
    ),
  );

  _loadQuestions() async {
    var createdManager = await QuestionManager.create(context, widget.collections);

    setState(() {
      questionManager = createdManager;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    players = Player.generate(widget.gameOptions.numberOfPeople);
    fortuneWheelItems = players
        .map((player) => FortuneItem(
              child: Emojis.getTransformedEmoji(player.emoji),
              style: FortuneItemStyle(
                color: player.color, // <-- custom circle slice fill color
                borderColor: Colors.black38, // <-- custom circle slice stroke color
                borderWidth: 1, // <-- custom circle slice stroke width
              ),
            ))
        .toList();
  }

  spinWheel() {
    setState(() {
      nextDurationInS = Random().nextInt(4) + 1;

      int winnerId = Random().nextInt(players.length);
      controller.add(winnerId);

      winner = new Winner(id: winnerId, color: players[winnerId].color, emoji: players[winnerId].emoji);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
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
                                selected: controller.stream,
                                indicators: <FortuneIndicator>[wheelIndicator],
                                items: fortuneWheelItems,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Color(0xffD30C7B)),
                                ),
                                SizedBox(height: 20.0),
                                Text("Ładowanie...")
                              ],
                            )),
                ),
              ],
            ),
          ),
          isInstructionVisible
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isInstructionVisible = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black45),
                    alignment: Alignment.topCenter,
                    padding: new EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .68, right: 20.0, left: 20.0, bottom: 20),
                    child: new Container(
                      width: MediaQuery.of(context).size.width,
                      child: new Container(
                        child: new Card(
                          color: Colors.white,
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(children: [
                              SizedBox(
                                height: 8,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: "❯ ",
                                      style: TextStyle(color: Theme.of(context).primaryColor),
                                    ),
                                    TextSpan(
                                      text: "Każdy wybiera swoje pole\n",
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                    TextSpan(
                                      text: "❯ ",
                                      style: TextStyle(color: Theme.of(context).primaryColor),
                                    ),
                                    TextSpan(
                                      text: "Wylosowany gracz odpowiada na pytanie",
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Text(
                                '(kliknij aby zamknąć)',
                                style: TextStyle(fontSize: 12.0, color: Color(0xff555555)),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
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
