import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/winner.model.dart';

class QuestionCard extends StatefulWidget {
  final Winner winner;

  QuestionCard({Key key, @required this.winner}) : super(key: key);

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
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [widget.winner.emoji, Text('(Kliknij aby zamknąć)')],
            )),
          ),
        ),
      ),
    );
  }
}
