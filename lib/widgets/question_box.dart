import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinner/utils/question.dart';

class QuestionBox extends StatefulWidget {
  final bool autofocus;
  final Question question;
  final Function onDelete;
  final ValueChanged<String> onChanged;
  final bool readonly;

  QuestionBox(
      {Key key,
      @required this.autofocus,
      @required this.question,
      @required this.onDelete,
      @required this.onChanged,
      this.readonly})
      : super(key: key);

  @override
  _QuestionBoxState createState() => _QuestionBoxState();
}

class _QuestionBoxState extends State<QuestionBox> {
  final TextEditingController textFieldController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    textFieldController.text = widget.question.text;

    SchedulerBinding.instance.addPostFrameCallback((Duration _) {
      if (textFieldController.text.isEmpty) {
        widget.question.focusNode.requestFocus();
      }
    });
  }

  void onUpdate(String text) {}

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
                // autofocus: widget.autofocus,
                focusNode: widget.question.focusNode,
                controller: textFieldController,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Pytanie",
                ),
                readOnly: widget.readonly != null),
          ),
          widget.readonly == null ? SizedBox(width: 16) : Container(),
          widget.readonly == null
              ? IconButton(
                  icon: Icon(Icons.close, color: Colors.black45),
                  onPressed: widget.onDelete)
              : Container()
        ],
      ),
    );
  }
}
