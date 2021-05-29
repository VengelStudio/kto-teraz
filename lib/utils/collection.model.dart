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
      print("File missing, creating defaults");
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

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name,
        "isTabu": isTabu,
        "questions":
            jsonEncode(questions.map((i) => i.toJson()).toList()).toString()
      };

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

    final customCollections = await readCollectionsFromFile();

    var isExisting =
        customCollections.indexWhere((element) => element.uuid == this.uuid);

    if (isExisting != -1) {
      customCollections[isExisting] = this;
    } else {
      customCollections.add(this);
    }

    var json2 = this.toJson();
    var json3 = jsonEncode(json2);
    var cc = jsonEncode(customCollections);
    // file.writeAsString('[{"_id": "60b1e514ed8f7953d92c8248","index": 0, "guid": "7afdda74-88d2-4c80-b5f2-ba5a7d449a30","isActive": false,"balance": "232"}]');

    return file.writeAsString(cc);
  }
}

//Saving collection into a json file
