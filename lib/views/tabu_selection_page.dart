import 'package:flutter/material.dart';

class TabuSelection extends StatefulWidget {
  @override
  _TabuSelectionState createState() => _TabuSelectionState();
}

class _TabuSelectionState extends State<TabuSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Czy twoja nowa kolekcja będzie zawierac pytania Tabu?',
              style: TextStyle(fontSize: 32.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Tak',
                    style: TextStyle(fontSize: 32.0, color: Colors.black),
                  ),
                ),
                SizedBox(width: 100.0),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Nie',
                    style: TextStyle(fontSize: 32.0, color: Colors.black),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
