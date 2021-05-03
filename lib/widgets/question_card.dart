import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/winner.model.dart';

class QuestionCard extends StatelessWidget {
  final Winner winner;

  QuestionCard({Key key, @required this.winner}) : super(key: key);

  bool get mounted => null;

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      print(winner);
    }

    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: const SizedBox(
            width: 600,
            height: 100,
            child: Text("xd"),
          ),
        ),
      ),
    );
  }
}
