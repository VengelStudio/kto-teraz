import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

class Question {
  String text;
  final double probability;
  final bool isTabu;
  final focusNode = FocusNode();

  Question({this.text, this.probability, this.isTabu});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] as String,
      probability: json['probability'] as double,
      isTabu: json['isTabu'] as bool,
    );
  }

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

    if (!isTabuEnabled) {
      component._questions =
          component._questions.where((question) => !question.isTabu).toList();
    }

    component._questions.shuffle();

    return component;
  }

  Question next() {
    Question result = _questions[questionIndex % _questions.length];
    questionIndex++;

    return result;
  }
}
