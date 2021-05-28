import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/collection.model.dart';
import 'package:flutter_spinner/views/collections_page.dart';
import 'package:flutter_spinner/views/about_page.dart';
import 'views/game_options_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Collection.createDefaultsIfMissing().then((value) =>
        Collection.readCollectionsFromFile().then((value) => print(value)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kto teraz?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(fontSize: 18.0),
            minimumSize: Size(220, 60),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 40),
                child: Text(
                  'Kto teraz?',
                  style: TextStyle(fontSize: 50.0),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameOptionsPage()),
                  );
                },
                child: Text("Zagraj"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CollectionsPage()),
                  );
                },
                child: Text("Kolekcje pytań"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
                child: Text("O aplikacji"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
