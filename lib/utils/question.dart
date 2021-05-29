import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  String text;
  final focusNode = FocusNode();

  Question({required this.text});

  factory Question.fromJson(Map<String, dynamic> data) =>
      _$QuestionFromJson(data);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  setText(String text) {
    this.text = text;
  }
}

class QuestionManager {
  int questionIndex = 0;
  List<Question> _questions = [];

  static Future<QuestionManager> create(BuildContext context) async {
    var component = QuestionManager();

    component._questions =
        (await Collection.readCollectionsFromFile())[0].questions;

    // if (!isTabuEnabled) {
    //   component._questions =
    //       component._questions.where((question) => !question.isTabu).toList();
    // }

    component._questions.shuffle();

    return component;
  }

  Question next() {
    Question result = _questions[questionIndex % _questions.length];
    questionIndex++;

    return result;
  }
}
