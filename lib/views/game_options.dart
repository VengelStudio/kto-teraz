import 'package:flutter/material.dart';

class GameOptions extends StatefulWidget {
  @override
  _GameOptionsState createState() => _GameOptionsState();
}

class _GameOptionsState extends State<GameOptions> {
  bool isTabuEnabled = false;
  int numberOfPeople = 0;

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
                width: 200.0,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Text(
                            "Liczba osób",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (text) {
                              numberOfPeople = int.parse(text);
                              print("Number of people: $text");
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
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
                          value: isTabuEnabled,
                          onChanged: (value) {
                            setState(() {
                              isTabuEnabled = value;
                              print(isTabuEnabled);
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
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Powrót',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Start'),
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
