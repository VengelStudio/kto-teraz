import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 60),
              child: Text(
                'O aplikacji',
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
                        "Poznajcie się w błyskawicznym tempie! ⚡\n\n🌟 Kręcicie kołem fortuny\n🌟 \"Kto teraz?\"\n🌟 Wylosowana osoba odpowiada na pytanie",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Text(
                        "Developerzy",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                    Text(
                      "Bartosz Kępka",
                      style: TextStyle(fontSize: 28),
                    ),
                    Text(
                      "Łukasz Blachnicki",
                      style: TextStyle(fontSize: 28),
                    ),
                  ],
                ),
                Text(
                  "Wsparcie",
                  style: TextStyle(fontSize: 28),
                ),
                SingleChildScrollView(
                    child: new Column(children: <Widget>[
                  Text(
                    "Zuzanna Olasek",
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    "Oliwia Olasek",
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    "Wiktoria Góralczyk",
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    "Monika Łodzińska",
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    "Sebastian Kula",
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    "Developerzy",
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    "Developerzy",
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    "Developerzy",
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    "Developerzy",
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    "Developerzy",
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    "Developerzy",
                    style: TextStyle(fontSize: 28),
                  ),
                  Text(
                    "Developerzy",
                    style: TextStyle(fontSize: 28),
                  ),
                ]))
              ],
            )),
          ],
        ),
      ),
    );
  }
}
