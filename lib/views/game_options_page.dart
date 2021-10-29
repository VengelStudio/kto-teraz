import 'dart:ui';

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "OPCJE GRY",
        style: GoogleFonts.signika(
            fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 0),
      )),
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
                        children: [
                          // TextButton(
                          //     child: Text(
                          //       gameOptions.numberOfPeople.toString(),
                          //       style: TextStyle(
                          //         fontSize: 38.0,
                          //         decoration: TextDecoration.underline,
                          //         color: Color(0xffD30C7B),
                          //       ),
                          //     ),
                          //     onPressed: () => showPickerNumber(context)),
                          NumberPicker(
                              onChanged: (value) =>
                                  handlePlayerCountChange(value)),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Zakres pytań",
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
                            child: CircularProgressIndicator(),
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
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    title: Row(
                                      children: [
                                        Text(
                                          collection.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        SizedBox(width: 5.0),
                                        Opacity(
                                          opacity: collection.isTabu ? 1.0 : 0,
                                          child: Text(
                                            '18+',
                                            style: GoogleFonts.signika(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: -0.2,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
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
                // Divider(),
                Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(bottom: 50, right: 28),
                  child: FloatingActionButton(
                    backgroundColor: selectedCollections.isEmpty
                        ? Theme.of(context).appBarTheme.backgroundColor
                        : Theme.of(context)
                            .floatingActionButtonTheme
                            .backgroundColor,
                    onPressed: () {
                      if (selectedCollections.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
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
                    child: const Icon(Icons.arrow_forward_ios,
                        size: 24, color: Colors.white),
                  ),
                ),
              ],
            ),
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

  handlePlayerCountChange(int value) {}
}
