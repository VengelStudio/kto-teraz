import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/collection.dart';
import 'utils/theme.dart';
import 'views/home_page.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
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
      theme: buildTheme(context),
      home: HomePage(),
    );
  }
}

