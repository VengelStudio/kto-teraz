import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<List<Question>> loadQuestions(BuildContext context) async {
  final data = await DefaultAssetBundle.of(context)
      .loadString('assets/json/questions.json');

  return compute(parseQuestions, data);
}

// A function that converts a response body into a List<Photo>.
List<Question> parseQuestions(String rawJson) {
  final parsed = jsonDecode(rawJson);

  return parsed.map<Question>((json) => Question.fromJson(json)).toList();
}

class Question {
  final String text;
  final double probability;
  final bool isTabu;

  Question({this.text, this.probability, this.isTabu});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] as String,
      probability: json['probability'] as double,
      isTabu: json['isTabu'] as bool,
    );
  }
}

class QuestionManager {
  int questionIndex = 0;
  List<Question> questions = [];

  static Future<QuestionManager> create(
      BuildContext context, bool isTabuEnabled) async {
    var component = QuestionManager();

    component.questions = (await loadQuestions(context));

    if (!isTabuEnabled) {
      component.questions =
          component.questions.where((question) => !question.isTabu).toList();
    }

    return component;
  }

  next() {
    var result = questions[questionIndex % questions.length];
    questionIndex++;

    return result;
  }
}
