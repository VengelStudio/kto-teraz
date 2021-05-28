import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Collection {
  String uuid = "";
  String name = "";
  bool isTabu = false;
  List questions = [];

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

  static Future<int> readCollectionsFromFile() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> saveCollection(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$questions');
  }
}

//Saving collection into a json file
