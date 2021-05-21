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
          children: [
            Text('Czy twoja nowa kolekcja będzie zawierac pytania Tabu?'),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Tak'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Nie'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
