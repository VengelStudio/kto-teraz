import 'package:flutter/material.dart';

class AddQuestionButton extends StatelessWidget {
  final VoidCallback onPressed;

  AddQuestionButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        margin: EdgeInsets.only(top: 16, bottom: 32, left: 16),
        child: Row(
          children: [
            Icon(Icons.add, color: Theme.of(context).primaryColor),
            Text(
              "Dodaj pytanie",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}