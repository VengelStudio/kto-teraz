import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/collection.dart';
import '../widgets/collection_card.dart';

import 'collection_editor.dart';

class CollectionsPage extends StatefulWidget {
  @override
  _CollectionsState createState() => _CollectionsState();
}

class _CollectionsState extends State<CollectionsPage> {
  var _collections = Collection.readAllCollections();

  refresCollections() {
    setState(() {
      _collections = Collection.readAllCollections();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "KOLEKCJE PYTAŃ",
        style: GoogleFonts.signika(
            fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 0),
      )),
      body: SafeArea(
        child: FutureBuilder<List<Collection>>(
          future: _collections,
          builder:
              (BuildContext context, AsyncSnapshot<List<Collection>> snapshot) {
            Widget child;
            if (snapshot.hasData) {
              child = ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var collection = snapshot.data![index];
                    return CollectionCard(
                      collection: collection,
                      refresh: refresCollections,
                      readonly: collection.uuid == "kto-teraz-original" ||
                          collection.uuid == "kto-teraz-tabu",
                    );
                  });
            } else if (snapshot.hasError) {
              child = Container(
                  alignment: Alignment.center,
                  child: Text(snapshot.error.toString(),
                      style: TextStyle(fontSize: 24.0)));
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
