import 'package:content_generator_front/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const font = GoogleFonts.audiowideTextTheme;
ThemeData appTheme() {
  return ThemeData(
    // scaffoldBackgroundColor: const Color(0xffC0C0C0),
    scaffoldBackgroundColor: Colors.amber.shade900,
    brightness: Brightness.dark,
    colorSchemeSeed: primaryColor,
    useMaterial3: true,
    textTheme:
        font.call().apply(displayColor: Colors.white, bodyColor: Colors.white),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.4),
      hintStyle: const TextStyle(color: primaryColor),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
    ),
  );
}
