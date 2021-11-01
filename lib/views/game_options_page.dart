import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kto_teraz/widgets/collection_card.dart';
import 'package:kto_teraz/widgets/number_picker.dart';
import '../utils/collection.dart';
import '../utils/options.model.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import 'game_page.dart';

class GameOptionsPage extends StatefulWidget {
  @override
  _GameOptionsPageState createState() => _GameOptionsPageState();
}

class _GameOptionsPageState extends State<GameOptionsPage> {
  GameOptions gameOptions = new GameOptions();
  List<Collection>? _allCollections;

  List<Collection> selectedCollections = [];

  @override
  void initState() {
    super.initState();

    loadAllCollections();
  }

  void loadAllCollections() async {
    var allCollections = await Collection.readAllCollections();
    setState(() {
      _allCollections = allCollections;
      selectedCollections = allCollections.getRange(0, 2).toList();
    });
  }

  void _toggleCollection(bool? value, Collection collection) {
    var newSelectedCollections = [...selectedCollections];

    if (value == null) {
      return;
    }

    if (value) {
      newSelectedCollections.add(collection);
    } else {
      newSelectedCollections.remove(collection);
    }

    setState(() {
      selectedCollections = newSelectedCollections;
    });
  }

  handlePlayerCountChange(int value) {
    setState(() {
      gameOptions.numberOfPeople = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "OPCJE GRY",
        style: GoogleFonts.signika(
            fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 0),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: selectedCollections.isEmpty
            ? Theme.of(context).appBarTheme.backgroundColor
            : Theme.of(context).floatingActionButtonTheme.backgroundColor,
        onPressed: () {
          if (selectedCollections.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: Text('Wybierz pytania aby kontynuować!'),
            ));
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GamePage(
                    gameOptions: gameOptions,
                    collections: selectedCollections)),
          );
        },
        child: const Icon(Icons.arrow_forward_ios_rounded,
            size: 24, color: Colors.white),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Liczba graczy",
                            style: Theme.of(context).textTheme.headline4,
                          )
                        ],
                      ),
                      Row(
                        children: [SizedBox(height: 20)],
                      ),
                      Row(
                        children: [
                          NumberPicker(
                              initial: gameOptions.numberOfPeople,
                              min: 2,
                              max: 20,
                              onChanged: (value) =>
                                  handlePlayerCountChange(value)),
                        ],
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Wybrane zestawy pytań",
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
                SizedBox(height: 5),
                Flexible(
                  child: _allCollections == null
                      ? Container(
                          alignment: Alignment.center,
                          child: SizedBox(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    Theme.of(context).primaryColor)),
                            width: 60,
                            height: 60,
                          ),
                        )
                      : ListView(
                          children: _allCollections!
                              .map(
                                (collection) => new Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xff212121)
                                                  .withOpacity(0.08),
                                              width: 1))),
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: CollectionCard(
                                      collection: collection,
                                      refresh: () => {},
                                      readonly: true,
                                      clickable: false,
                                    ),
                                    value: selectedCollections
                                        .contains(collection),
                                    onChanged: (bool? value) =>
                                        _toggleCollection(value, collection),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
