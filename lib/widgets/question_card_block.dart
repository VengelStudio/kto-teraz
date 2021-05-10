import 'package:flutter/material.dart';
import 'dart:math' as math;

class QuestionCardBlock extends StatelessWidget {
  const QuestionCardBlock({
    Key key,
    this.text,
    this.inverted = false,
  }) : super(key: key);

  final String text;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: inverted ? -math.pi : 0,
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        color: Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
