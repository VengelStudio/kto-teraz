import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/question.dart';
import 'package:flutter_spinner/utils/winner.model.dart';
import 'package:flutter_spinner/widgets/question_card_block.dart';

class QuestionCard extends StatelessWidget {
  final Winner winner;
  final Question question;

  QuestionCard({Key? key, required this.winner, required this.question})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            Navigator.of(context).pop();
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: <Widget>[
              Container(color: Color(0xF2F2F2F2)),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 120.0),
                    Flexible(
                        // fit: FlexFit.tight,
                        child: Transform.scale(scale: 2, child: winner.emoji)),
                    // SizedBox(height: 20.0),
                    SizedBox(height: 120.0),
                    Column(
                      children: [
                        QuestionCardBlock(text: question.text),
                        SizedBox(height: 20.0),
                        QuestionCardBlock(text: question.text, inverted: true),
                      ],
                    ),
                    Spacer(),
                    Text(
                      '(kliknij aby zamknąć)',
                      style:
                          TextStyle(fontSize: 15.0, color: Color(0xff555555)),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
