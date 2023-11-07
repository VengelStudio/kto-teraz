import 'package:flutter/material.dart';
import '../utils/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  String text;
  final focusNode = FocusNode();

  Question({required this.text});

  factory Question.fromJson(Map<String, dynamic> data) => _$QuestionFromJson(data);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  setText(String text) {
    this.text = text;
  }
}

class QuestionManager {
  int questionIndex = 0;
  List<Question> _questions = [];

  static Future<QuestionManager> create(BuildContext context, List<Collection> collections) async {
    var component = QuestionManager();

    component._questions = collections.map((collection) => collection.questions).toList().expand((i) => i).toList();

    component._questions.shuffle();

    return component;
  }

  Question next() {
    Question result = _questions[questionIndex % _questions.length];
    questionIndex++;

    return result;
  }
}
