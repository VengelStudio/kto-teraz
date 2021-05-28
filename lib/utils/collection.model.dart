import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinner/utils/questions.dart';
import 'package:path_provider/path_provider.dart';

class Collection {
  String uuid = "";
  String name = "";
  bool isTabu = false;
  List<Question> questions = [];

  Collection({this.uuid, this.name, this.isTabu, this.questions});

  void setUuid(String uuid) {
    this.uuid = uuid;
  }

  void setName(String name) {
    this.name = name;
  }

  void setQuestions(List questions) {
    this.questions = questions;
  }

  void setTabu(bool isTabu) {
    this.isTabu = isTabu;
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/collections.json');
  }

  static Future<File> createDefaultsIfMissing() async {
    final file = await _localFile;

    if (!(await file.exists())) {
      file.writeAsString('[]');
    }
  }

  static Future<List<Collection>> readCollectionsFromFile() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return List.from(json.decode(contents));
    } catch (e) {
      print(e);
      // If encountering an error, return 0
      return [];
    }
  }

  static Future<List<Collection>> readDefaultCollections() async {
    final data =
        await rootBundle.loadString('assets/json/defaultCollections.json');

    return compute(parseCollections, data);
  }

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
        uuid: json['uuid'],
        name: json['name'],
        isTabu: json['isTabu'],
        questions:
            List.from(json["questions"].map((x) => Question.fromJson(x))));
  }

  static List<Collection> parseCollections(String rawJson) {
    final parsed = jsonDecode(rawJson);

    return parsed.map<Collection>((json) => Collection.fromJson(json)).toList();
  }

  static Future<List<Collection>> readAllCollections() async {
    final builtInCollections = await readDefaultCollections();
    final customCollections = await readCollectionsFromFile();

    return [...builtInCollections, ...customCollections];
  }

  Future<File> saveCollection() async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('xd');
  }
}

//Saving collection into a json file
