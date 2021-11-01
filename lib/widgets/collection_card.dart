import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/collection.dart';
import '../views/collection_editor.dart';
import 'package:google_fonts/google_fonts.dart';

class CollectionCard extends StatelessWidget {
  final Collection collection;
  final bool readonly;
  final bool clickable;
  final Function refresh;

  CollectionCard(
      {Key? key,
      required this.collection,
      required this.refresh,
      this.readonly = false,
      this.clickable = true})
      : super(key: key);

  void navigateToEditor(BuildContext context) {
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
  }

  showAlertDialog(BuildContext context) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      content: Text("Czy na pewno chcesz usunąć pulę pytań?"),
      actions: [
        CupertinoDialogAction(
          child: TextButton(
            onPressed: () {
              collection.deleteCollection();
              Navigator.of(context).pop();
              refresh();
            },
            child: Text("Usuń", style: TextStyle(fontSize: 16)),
          ),
        ),
        CupertinoDialogAction(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Anuluj", style: TextStyle(fontSize: 16)),
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

  void handleCardTap(BuildContext context) {
    if (clickable) {
      navigateToEditor(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => handleCardTap(context),
            child: Container(
              constraints: BoxConstraints(minHeight: 48),
              child: Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Flexible(
                        flex: 1,
                        child: Row(
                          children: [
                            Flexible(
                                flex: 1,
                                child: Text(
                                  collection.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.signika(
                                    fontSize: 16,
                                  ),
                                )),
                            SizedBox(width: 8.0),
                            collection.isTabu
                                ? RawMaterialButton(
                                    onPressed: () {},
                                    constraints: BoxConstraints(),
                                    padding:
                                        EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
                                    child: Text(
                                      '18+',
                                      style: new TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(18.0),
                                    ),
                                    fillColor: Colors.red.shade300,
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 8.0),
                        readonly
                            ? SizedBox.shrink()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.edit_rounded,
                                          color: Colors.grey.shade600),
                                      onPressed: () =>
                                          navigateToEditor(context)),
                                  IconButton(
                                      icon: Icon(Icons.delete_forever_rounded,
                                          color: Colors.grey.shade600),
                                      onPressed: () {
                                        showAlertDialog(context);
                                      })
                                ],
                              )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
