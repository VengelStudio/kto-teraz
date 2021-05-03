import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/options.model.dart';
import 'package:numberpicker/numberpicker.dart';

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
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => setState(() {
                            final finalValue = gameOptions.numberOfPeople - 1;
                            gameOptions.numberOfPeople =
                                finalValue.clamp(2, 15);
                          }),
                        ),
                        NumberPicker(
                          value: gameOptions.numberOfPeople,
                          minValue: 2,
                          maxValue: 15,
                          itemWidth: 40,
                          itemCount: 1,
                          step: 1,
                          haptics: true,
                          onChanged: (value) => setState(
                              () => gameOptions.numberOfPeople = value),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => setState(() {
                            final finalValue = gameOptions.numberOfPeople + 1;
                            gameOptions.numberOfPeople =
                                finalValue.clamp(2, 15);
                          }),
                        ),
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
                        "Liczba osób",
                        style: TextStyle(fontSize: 20),
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
                            builder: (context) => GamePage(
                                gameOptions.numberOfPeople,
                                gameOptions.isTabuEnabled)),
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
}
