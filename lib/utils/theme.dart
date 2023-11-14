import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.blue,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(fontSize: 18.0),
        minimumSize: Size(220, 60),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        backgroundColor: Color(0xffD30C7B),
        shape: StadiumBorder(),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: TextStyle(fontSize: 18.0),
        minimumSize: Size(220, 60),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        backgroundColor: Color(0xffD30C7B),
        shape: StadiumBorder(
          side: BorderSide(width: 8, color: Colors.black),
        ),
      ),
    ),
    textTheme: GoogleFonts.ralewayTextTheme(
      Theme.of(context).textTheme,
    ),
    primaryColor: Color(0xffD30C7B),
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
  );
}