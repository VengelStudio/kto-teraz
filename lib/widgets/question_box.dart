import 'dart:math';

import 'package:flutter/material.dart';

class QuestionBox extends StatelessWidget {
  final String title;
  final Function callback;

  QuestionBox({
    Key key,
    @required this.title,
    @required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20.0),
          ),
          Spacer(),
          IconButton(icon: Icon(Icons.delete), onPressed: this.callback)
        ],
      ),
    );
  }
}
