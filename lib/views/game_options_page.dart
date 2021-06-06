import 'dart:ui';

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Text(
                            "Liczba graczy:",
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                child: Text(
                                  gameOptions.numberOfPeople.toString(),
                                  style: TextStyle(
                                    fontSize: 38.0,
                                    decoration: TextDecoration.underline,
                                    color: Color(0xffD30C7B),
                                  ),
                                ),
                                onPressed: () => showPickerNumber(context)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              // Divider(),
              // SizedBox(height: 8),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Text(
                      "Kolekcje pytań:",
                      style: TextStyle(fontSize: 28),
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
              Flexible(
                child: _allCollections == null
                    ? Container(
                        alignment: Alignment.center,
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        ),
                      )
                    : ListView(
                        children: _allCollections!
                            .map(
                              (collection) => new Container(
                                child: CheckboxListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 24),
                                  title: Row(
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
                                  value:
                                      selectedCollections.contains(collection),
                                  onChanged: (bool? value) =>
                                      _toggleCollection(value, collection),
                                ),
                              ),
                            )
                            .toList(),
                      ),
              ),
              // Divider(),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 30),
                width: MediaQuery.of(context).size.width / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (selectedCollections.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(new SnackBar(
                            content: Text('Wybierz kolekcje pytań!'),
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
                      child: Text(
                        'START',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showPickerNumber(BuildContext context) {
    new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 2, end: 12),
        ]),
        hideHeader: true,
        title: new Text("Wybierz liczbę graczy"),
        textAlign: TextAlign.center,
        confirmText: "Zapisz",
        cancelText: "Anuluj",
        itemExtent: 60.0,
        textStyle: TextStyle(fontSize: 30.0, color: Colors.black),
        selectedTextStyle: TextStyle(fontSize: 40.0),
        cancelTextStyle: TextStyle(fontSize: 20.0, color: Colors.black),
        confirmTextStyle: TextStyle(fontSize: 20.0, color: Colors.black),
        onConfirm: (Picker picker, List value) {
          setState(() {
            gameOptions.numberOfPeople = picker.getSelectedValues()[0];
          });
        }).showDialog(context);
  }
}
