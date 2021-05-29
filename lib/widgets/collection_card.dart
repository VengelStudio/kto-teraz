import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/collection.dart';
import 'package:flutter_spinner/views/collection_editor.dart';

class CollectionCard extends StatelessWidget {
  final Collection collection;
  final bool readonly;

  CollectionCard({Key? key, required this.collection, this.readonly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CollectionEditor(
                    uuid: collection.uuid,
                    name: collection.name,
                    isTabu: collection.isTabu,
                    questions: collection.questions,
                    readonly: readonly,
                  )),
        );
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
        width: MediaQuery.of(context).size.width,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
        child: Text(
          collection.name,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
