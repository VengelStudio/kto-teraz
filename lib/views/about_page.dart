import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 60, bottom: 30),
          child: Text(
            'Kto teraz?',
            style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                        child: Text(
                      "Poznajcie się w błyskawicznym tempie! ⚡\n\n🌟 Kręcicie kołem fortuny\n🌟 \"Kto teraz?\"\n🌟 Wylosowana osoba odpowiada na pytanie",
                      style: TextStyle(fontSize: 18),
                    )),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 5),
                        child: Text(
                          "Developerzy",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 5),
                        child: Text(
                          "Wsparcie",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
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
                    ])
              ],
            )),
      ],
    )));
  }
}
