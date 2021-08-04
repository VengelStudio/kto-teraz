import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/collection.dart';
import 'views/collections_page.dart';
import 'views/about_page.dart';
import 'views/game_options_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

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
            minimumSize: Size(220, 60),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            primary: Color(0xffD30C7B),
            shape: StadiumBorder(),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: Color(0xff383838),
            minimumSize: Size(220, 60),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            primary: Colors.white,
            shape: StadiumBorder(
              side: BorderSide(width: 8, color: Colors.transparent),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Color(0xff383838),
          ),
        ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: Color(0xff383838),
            ),
        textTheme: TextTheme(
          headline1: GoogleFonts.roboto(
              fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          headline2: GoogleFonts.roboto(
              fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          headline3:
              GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
          headline4: GoogleFonts.roboto(
              fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          headline5:
              GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
          headline6: GoogleFonts.roboto(
              fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
          subtitle1: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
          subtitle2: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
          bodyText1: GoogleFonts.roboto(
              fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          bodyText2: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
          button: GoogleFonts.signika(
              fontSize: 24, fontWeight: FontWeight.w300, letterSpacing: 0.14),
          caption: GoogleFonts.roboto(
              fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
          overline: GoogleFonts.roboto(
              fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
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
        child: Align(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(maxWidth: 270),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'KTO',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.bebasNeue(
                            height: 0.9,
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 100,
                            color: Color(0xffD30C7B)),
                      ),
                      Text(
                        'TERAZ?',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.bebasNeue(
                            height: 0.9,
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 100,
                            color: Color(0xffD30C7B)),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GameOptionsPage()),
                    );
                  },
                  child: Text("ZAGRAJ"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xff383838)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CollectionsPage()),
                    );
                  },
                  child: Text("KOLEKCJE PYTAŃ"),
                ),
                SizedBox(height: 20),
                TextButton(
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
      ),
    );
  }
}
