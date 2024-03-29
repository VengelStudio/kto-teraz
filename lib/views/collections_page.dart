import 'package:flutter/material.dart';
import '../utils/collection.dart';
import '../widgets/collection_card.dart';

import 'collection_editor/collection_editor.dart';

class CollectionsPage extends StatefulWidget {
  @override
  _CollectionsState createState() => _CollectionsState();
}

class _CollectionsState extends State<CollectionsPage> {
  var _collections = Collection.readAllCollections();

  refreshCollections() {
    setState(() {
      _collections = Collection.readAllCollections();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Collection>>(
          future: _collections,
          builder: (BuildContext context, AsyncSnapshot<List<Collection>> snapshot) {
            Widget child;
            if (snapshot.hasData) {
              child = ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length + 1, //add room for the title
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return new Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text('Kolekcje pytań', style: TextStyle(fontSize: 32.0)),
                      );
                    }
                    index -= 1;
                    var collection = snapshot.data![index];
                    return CollectionCard(
                      collection: collection,
                      refresh: refreshCollections,
                      readonly: collection.uuid == "kto-teraz-original" || collection.uuid == "kto-teraz-tabu",
                    );
                  });
            } else if (snapshot.hasError) {
              child = Container(
                  alignment: Alignment.center,
                  child: Text(snapshot.error.toString(), style: TextStyle(fontSize: 24.0)));
            } else {
              child = Container(
                alignment: Alignment.center,
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
              );
            }
            return child;
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 42.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CollectionEditor(
                      uuid: UniqueKey().toString(),
                      name: "",
                      isTabu: false,
                      refresh: refreshCollections,
                      questions: [])),
            );
          },
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
    );
  }
}
