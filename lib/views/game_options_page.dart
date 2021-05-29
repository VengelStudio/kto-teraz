import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/collection.dart';
import 'package:flutter_spinner/utils/options.model.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'game_page.dart';

class GameOptionsPage extends StatefulWidget {
  @override
  _GameOptionsPageState createState() => _GameOptionsPageState();
}

class _GameOptionsPageState extends State<GameOptionsPage> {
  GameOptions gameOptions = new GameOptions();
  List<Collection>? _allCollections;

  @override
  void initState() {
    super.initState();

    loadAllCollections();
  }

  void loadAllCollections() async {
    var allCollections = await Collection.readAllCollections();
    setState(() {
      _allCollections = allCollections;
    });
  }

  List<Collection> selectedCollections = [];

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

    print(newSelectedCollections);

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
                margin: const EdgeInsets.only(bottom: 60),
                child: Text(
                  'Opcje gry',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: Text(
                          "Liczba osób",
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              child: Text(
                                gameOptions.numberOfPeople.toString(),
                                style: TextStyle(fontSize: 38.0),
                              ),
                              onPressed: () => showPickerNumber(context)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              )),
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
                                  title: new Text(collection.name),
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
              Container(
                margin: const EdgeInsets.only(top: 60),
                width: MediaQuery.of(context).size.width / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GamePage(
                                  gameOptions: gameOptions,
                                  collections: selectedCollections)),
                        );
                      },
                      child: Text(
                        'Start',
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
        title: new Text("Liczba osób"),
        textAlign: TextAlign.center,
        confirmText: "Wybierz",
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
