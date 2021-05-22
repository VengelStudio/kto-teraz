import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Collection {
  String name = "";
  bool isTabu = false;
  List questions = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/collection.txt');
  }

  Future<int> readCollection() async {
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

  Future<File> saveCollections(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$questions');
  }
}