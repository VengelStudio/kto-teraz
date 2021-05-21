import 'package:flutter/material.dart';
import 'package:flutter_spinner/views/collection_creator.dart';

class TabuSelection extends StatelessWidget {
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CollectionCreator(
                          isTabu: true,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Tak',
                    style: TextStyle(fontSize: 32.0, color: Colors.black),
                  ),
                ),
                SizedBox(width: 100.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CollectionCreator(
                          isTabu: false,
                        ),
                      ),
                    );
                  },
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
