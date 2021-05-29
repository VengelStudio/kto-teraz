import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinner/utils/question.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'collection.g.dart';

@JsonSerializable(explicitToJson: true)
class Collection {
  String uuid;
  String name;
  bool isTabu;
  List<Question> questions;

  Collection(
      {required this.uuid,
      required this.name,
      required this.isTabu,
      required this.questions});

  void setUuid(String uuid) {
    this.uuid = uuid;
  }

  void setName(String name) {
    this.name = name;
  }

  void setQuestions(List<Question> questions) {
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

  static void createDefaultsIfMissing() async {
    final file = await _localFile;

    if (!(await file.exists())) {
      print("File missing, creating defaults");
      file.writeAsString('[]');
    }
  }

  static Future<List<Collection>> readCollectionsFromFile() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();

      var list = List<Collection>.from(
        json.decode(contents).map<Collection>(
              (dynamic item) => Collection.fromJson(item),
            ),
      );

      return list;
    } catch (e) {
      return [];
    }
  }

  static Future<List<Collection>> readDefaultCollections() async {
    final data =
        await rootBundle.loadString('assets/json/defaultCollections.json');

    return compute(parseCollections, data);
  }

  factory Collection.fromJson(Map<String, dynamic> data) =>
      _$CollectionFromJson(data);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);

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

    var newCustomCollections = jsonEncode(customCollections);

    return file.writeAsString(newCustomCollections);
  }

  Future<File> deleteCollection() async {
    final file = await _localFile;

    final customCollections = await readCollectionsFromFile();

    customCollections.removeWhere((element) => element.uuid == this.uuid);

    var newCustomCollections = jsonEncode(customCollections);

    return file.writeAsString(newCustomCollections);
  }
}

//Saving collection into a json file
