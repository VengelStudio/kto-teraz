import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../utils/question.dart';

typedef DeleteCallback = void Function();

class QuestionBox extends StatefulWidget {
  final bool autofocus;
  final Question question;
  final DeleteCallback onDelete;
  final ValueChanged<String> onChanged;
  final bool readonly;

  QuestionBox(
      {Key? key,
      required this.autofocus,
      required this.question,
      required this.onDelete,
      required this.onChanged,
      this.readonly = false})
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
                  hintText: "Treść pytania",
                ),
                readOnly: !widget.readonly),
          ),
          widget.readonly ? SizedBox(width: 16) : Container(),
          widget.readonly
              ? IconButton(icon: Icon(Icons.close, color: Colors.black87), onPressed: widget.onDelete)
              : Container()
        ],
      ),
    );
  }
}
