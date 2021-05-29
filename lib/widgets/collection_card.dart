import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/collection.dart';
import 'package:flutter_spinner/views/collection_editor.dart';

class CollectionCard extends StatelessWidget {
  final Collection collection;
  final bool readonly;
  final Function refresh;

  CollectionCard(
      {Key? key,
      required this.collection,
      required this.refresh,
      this.readonly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
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
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2)),
                child: Text(
                  collection.name,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
          if (!readonly)
            Expanded(
                flex: 0,
                child: IconButton(
                    icon: Icon(Icons.close, color: Colors.black45),
                    onPressed: () {
                      collection.deleteCollection();
                      refresh();
                    }))
          else
            Opacity(
              opacity: 0,
              child: Expanded(
                  flex: 0,
                  child: IconButton(
                      icon: Icon(Icons.close, color: Colors.black45),
                      onPressed: () {})),
            )
        ],
      ),
    );
  }
}
