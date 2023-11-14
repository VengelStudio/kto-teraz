import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kto_teraz/views/about_page.dart';
import 'package:kto_teraz/views/collections_page.dart';
import 'package:kto_teraz/views/game_options_page.dart';

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
                      textStyle: Theme.of(context).textTheme.headlineMedium,
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CollectionsPage()),
                  );
                },
                child: Text("KOLEKCJE PYTAŃ"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
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
