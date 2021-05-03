import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_spinner/utils/emojis.utils.dart';
import 'package:flutter_spinner/utils/winner.model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_spinner/widgets/question_card.dart';

class GamePage extends StatefulWidget {
  final int numberOfPeople;
  final bool isTabuEnabled;

  const GamePage(this.numberOfPeople, this.isTabuEnabled);

  @override
  _GameState createState() => _GameState();
}

class PlayerSlice {
  int id;
  Color color;
  SvgPicture emoji;

  PlayerSlice({int id, Color color, SvgPicture emoji}) {
    this.id = id;
    this.color = color;
    this.emoji = emoji;
  }

  static List<PlayerSlice> generate(int playerCount) {
    List colors = new List.generate(playerCount,
        (i) => HSLColor.fromAHSL(1, 360 * i / playerCount, 0.7, 0.5).toColor());

    return new List.generate(
        playerCount,
        (i) =>
            new PlayerSlice(id: i, color: colors[i], emoji: Emojis.getSvg(i)));
  }
}

Future<List<Question>> loadQuestions(BuildContext context) async {
  final data = await DefaultAssetBundle.of(context)
      .loadString('assets/json/questions.json');

  return compute(parseQuestions, data);
}

// A function that converts a response body into a List<Photo>.
List<Question> parseQuestions(String rawJson) {
  final parsed = jsonDecode(rawJson);

  return parsed.map<Question>((json) => Question.fromJson(json)).toList();
}

class Question {
  final String text;
  final double probability;
  final bool isTabu;

  Question({this.text, this.probability, this.isTabu});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] as String,
      probability: json['probability'] as double,
      isTabu: json['isTabu'] as bool,
    );
  }
}

class _GameState extends State<GamePage> {
  int selectedPlayerIndex = 0;
  int nextDurationInS = 4;
  List<Question> questions = [];
  int questionIndex = 0;

  _loadQuestions() async {
    var fetchedQuestions = await loadQuestions(context);

    setState(() {
      questions = fetchedQuestions;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Winner winner = new Winner();

  @override
  Widget build(BuildContext context) {
    final players = PlayerSlice.generate(widget.numberOfPeople);

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

        winner.index = selectedPlayerIndex;
        winner.color = players[selectedPlayerIndex].color;
        winner.emoji = players[selectedPlayerIndex].emoji;
      });
    }

    showQuestionCard(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return QuestionCard(winner: winner);
        },
      );
    }

    openQuestion() {
      showQuestionCard(context);
      print(winner);
    }

    return Scaffold(
      body: GestureDetector(
        child: Column(
          children: [
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: questions.length > 0
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
                            selected: selectedPlayerIndex,
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
                            CircularProgressIndicator(),
                            Text("Ładowanie pytań...")
                          ],
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
