import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
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
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: [
                      collection.isTabu
                          ? Opacity(opacity: 1.0, child: Text('18+'))
                          : Opacity(opacity: 0, child: Text('18+')),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          collection.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ],
                  ),
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
                    showAlertDialog(context);
                    // collection.deleteCollection();
                    // refresh();
                  }),
            )
          else
            Opacity(
              opacity: 0,
              child: Expanded(
                flex: 0,
                child: IconButton(
                    icon: Icon(Icons.close, color: Colors.black45),
                    onPressed: () {}),
              ),
            )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text("Uwaga"),
      content: Text("Czy na pewno chcesz usunąć kolekcje pytań?"),
      actions: [
        CupertinoDialogAction(
          child: TextButton(
            onPressed: () {
              collection.deleteCollection();
              Navigator.of(context).pop();
              refresh();
            },
            child: Text("Tak"),
          ),
        ),
        CupertinoDialogAction(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Nie"),
          ),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
