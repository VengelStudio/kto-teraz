import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/options.model.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'game_page.dart';

class GameOptionsPage extends StatefulWidget {
  @override
  _GameOptionsPageState createState() => _GameOptionsPageState();
}

class _GameOptionsPageState extends State<GameOptionsPage> {
  GameOptions gameOptions = new GameOptions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Text(
                        "Pytania tabu?",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                    Flexible(
                        child: Switch(
                      value: gameOptions.isTabuEnabled,
                      onChanged: (value) {
                        setState(() {
                          gameOptions.isTabuEnabled = value;
                        });
                      },
                      activeColor: Colors.blue,
                    ))
                  ],
                ),
              ],
            )),
            Container(
              margin: const EdgeInsets.only(top: 60),
              width: MediaQuery.of(context).size.width / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GamePage(gameOptions)),
                      );
                      // Navigator.pop(context);
                      // print('Number of people: $numberOfPeople');
                      // print('Is tabu enabled: $isTabuEnabled');
                    },
                    child: Text(
                      'Start',
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Powrót',
                    ),
                  ),
                ],
              ),
            ),
          ],
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
