import 'package:flutter/material.dart';
import 'utils/collection.dart';
import 'views/collections_page.dart';
import 'views/about_page.dart';
import 'views/game_options_page.dart';
import 'package:google_fonts/google_fonts.dart';

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
    super.initState();

    Collection.createDefaultsIfMissing();
    Collection.readCollectionsFromFile();
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
            primary: Color(0xffD30C7B),
            shape: StadiumBorder(),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            textStyle: TextStyle(fontSize: 18.0),
            minimumSize: Size(220, 60),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            primary: Color(0xffD30C7B),
            shape: StadiumBorder(
              side: BorderSide(width: 8, color: Colors.black),
            ),
          ),
        ),
        textTheme: GoogleFonts.ralewayTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: Color(0xffD30C7B),
        toggleableActiveColor: Color(0xffD30C7B),
        inputDecorationTheme: new InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffD30C7B),
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xffD30C7B),
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
                  'KTO\nTERAZ?',
                  style: GoogleFonts.bebasNeue(
                      height: 0.9,
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 80,
                      color: Color(0xffD30C7B)
                      // fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameOptionsPage()),
                  );
                },
                child: Text("ZAGRAJ"),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CollectionsPage()),
                  );
                },
                child: Text("KOLEKCJE PYTAŃ"),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
                child: Text("O GRZE"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
