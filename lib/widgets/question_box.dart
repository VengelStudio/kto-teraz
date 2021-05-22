import 'dart:math';

import 'package:flutter/material.dart';

class QuestionBox extends StatefulWidget {
  final String title;
  final Function onDelete;
  final bool autofocus;

  QuestionBox({
    Key key,
    @required this.title,
    @required this.onDelete,
    @required this.autofocus,
  }) : super(key: key);

  @override
  _QuestionBoxState createState() => _QuestionBoxState();
}

class _QuestionBoxState extends State<QuestionBox> {
  final TextEditingController textFieldController = new TextEditingController();

  @override
  void initState() {
    textFieldController.text = widget.title;
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 16.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Flexible(
            child: TextField(
                autofocus: widget.autofocus,
                controller: textFieldController,
                onChanged: (text) {
                  print(text);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Pytanie",
                )),
          ),
          SizedBox(width: 16),
          IconButton(
              icon: Icon(Icons.close, color: Colors.black45),
              onPressed: widget.onDelete)
        ],
      ),
    );
  }
}
