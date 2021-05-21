import 'package:flutter/material.dart';
import 'package:flutter_spinner/views/tabu_selection_page.dart';
import 'package:flutter_spinner/widgets/collection_card.dart';

class Collections extends StatefulWidget {
  @override
  _CollectionsState createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  List<String> collections = [
    "Kto teraz",
    "Impreza",
    "Randka",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: collections.length + 1, //add room for the title
            itemBuilder: (context, index) {
              if (index == 0) {
                return new Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text('Kolekcje', style: TextStyle(fontSize: 32.0)),
                );
              }
              index -= 1;
              return CollectionCard(title: collections[index]);
            }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 42.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TabuSelection()),
            );
          },
          shape: StadiumBorder(side: BorderSide(color: Colors.black, width: 3)),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
    );
  }
}
