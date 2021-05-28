import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/collection.model.dart';
import 'package:flutter_spinner/widgets/collection_card.dart';

import 'collection_editor.dart';

class CollectionsPage extends StatefulWidget {
  @override
  _CollectionsState createState() => _CollectionsState();
}

class _CollectionsState extends State<CollectionsPage> {
  List<Collection> collections = [];

  @override
  void initState() {
    super.initState();
    this.loadCollections();
  }

  void loadCollections() async {
    this.collections = await Collection.readCollectionsFromFile();
    print(this.collections);
  }

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
              return CollectionCard(title: collections[index].name);
            }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 42.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CollectionEditor()),
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
