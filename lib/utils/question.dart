import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

Future<List<Question>> loadQuestions(BuildContext context) async {
  final data = await DefaultAssetBundle.of(context)
      .loadString('assets/json/defaultCollections.json');

  return compute(parseQuestions, data);
}

// A function that converts a response body into a List<Photo>.
List<Question> parseQuestions(String rawJson) {
  final parsed = jsonDecode(rawJson);

  return parsed.map<Question>((json) => Question.fromJson(json)).toList();
}

@JsonSerializable()
class Question {
  String text;
  final focusNode = FocusNode();

  Question({this.text});

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

  static Future<QuestionManager> create(
      BuildContext context, bool isTabuEnabled) async {
    var component = QuestionManager();

    component._questions = (await loadQuestions(context));

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
