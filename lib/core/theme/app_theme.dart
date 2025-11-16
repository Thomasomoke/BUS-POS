import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color.fromRGBO(255, 255, 255, 1),
      secondary: Color.fromRGBO(23, 23, 23, 1),
      error:  Color(0xFFB00020),
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 250, 250, 250),
    cardColor: const Color(0xA6424242),
    primaryColor: const Color.fromARGB(255, 25, 118, 210),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lora(
        fontSize: 24,
        color: const Color.fromARGB(255, 66, 66, 66),
        fontWeight: FontWeight.w700,
      ),
      displayMedium: GoogleFonts.lora(
        fontSize: 20,
        color: const Color.fromARGB(255, 66, 66, 66),
        fontWeight: FontWeight.w700,
      ),
      displaySmall: GoogleFonts.lora(
        fontSize: 16,
        color: const Color.fromARGB(255, 66, 66, 66),
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: GoogleFonts.lora(
        fontSize: 24,
        color: const Color.fromARGB(255, 66, 66, 66),
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: GoogleFonts.lora(
        fontSize: 18,
        color: const Color.fromARGB(255, 66, 66, 66),
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.lora(
        fontSize: 16,
        color: const Color.fromARGB(255, 66, 66, 66),
        fontWeight: FontWeight.w400,
      ),
      labelMedium: GoogleFonts.lora(
        fontSize: 16,
        color: const Color.fromARGB(255, 66, 66, 66),
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.lora(
        fontSize: 18,
        color: const Color.fromARGB(255, 66, 66, 66),
        fontWeight: FontWeight.w400,
      ),
      labelSmall: GoogleFonts.lora(
        fontSize: 14,
        color: const Color.fromARGB(255, 66, 66, 66),
        fontWeight: FontWeight.w400,
      ),
    ),
    useMaterial3: true,
  );
}
