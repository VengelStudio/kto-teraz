import 'package:flutter/material.dart';

class CollectionCreator extends StatefulWidget {
  final bool isTabu;

  CollectionCreator({Key key, @required this.isTabu}) : super(key: key);

  @override
  _CollectionCreatorState createState() => _CollectionCreatorState();
}

class _CollectionCreatorState extends State<CollectionCreator> {
  @override
  void initState() {
    print(widget.isTabu);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
