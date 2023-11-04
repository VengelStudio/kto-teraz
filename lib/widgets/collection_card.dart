import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/collection.dart';
import '../views/collection_editor.dart';
import 'package:google_fonts/google_fonts.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38, width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: [
                      Opacity(
                        opacity: collection.isTabu ? 1.0 : 0,
                        child: Text(
                          '18+',
                          style: GoogleFonts.lato(
                            color: Colors.red,
                          ),
                        ),
                      ),
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
                  icon: Icon(Icons.close, color: Colors.black87),
                  onPressed: () {
                    showAlertDialog(context);
                  }),
            )
          else
            Opacity(
              opacity: 0,
              child: IconButton(
                  icon: Icon(Icons.close, color: Colors.black26),
                  onPressed: () {}),
            )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text("Uwaga"),
      content: Text("Czy na pewno chcesz usunąć kolekcję pytań?"),
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
