import 'dart:math';

import 'package:flutter/material.dart';

class CollectionCard extends StatelessWidget {
  final String title;

  CollectionCard({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(title);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
        width: MediaQuery.of(context).size.width,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
        child: Text(
          title,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
