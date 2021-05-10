import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/questions.dart';
import 'dart:math' as math;
import 'package:flutter_spinner/utils/winner.model.dart';

class QuestionCard extends StatefulWidget {
  final Winner winner;
  final Question question;

  QuestionCard({Key key, @required this.winner, @required this.question})
      : super(key: key);

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            setState(() {
              Navigator.of(context).pop();
            });
            print(widget.winner.index);
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: <Widget>[
              Container(color: Color(0xF2F2F2F2)),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.0),
                    Transform.scale(scale: 2, child: widget.winner.emoji),
                    SizedBox(height: 80.0),
                    Transform.rotate(
                      angle: -math.pi,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        color: Color(0xFFFFFFFF),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 32.0),
                          child: Text(
                            widget.question.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      color: Color(0xFFFFFFFF),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 32.0),
                        child: Text(
                          widget.question.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32.0,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Text('(Kliknij aby zamknąć)'),
                    SizedBox(
                      height: 32,
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
