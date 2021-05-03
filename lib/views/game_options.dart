import 'package:flutter/material.dart';
import 'game_page.dart';

class GameOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: Text(
                'Opcje gry',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamePage()),
                );
              },
              child: Text('Start'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Powrót'),
            ),
          ],
        ),
      ),
    );
  }
}
