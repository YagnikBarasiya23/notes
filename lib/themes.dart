import 'package:flutter/material.dart';

class ThemeHelper {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins',
      ),
    ),
    textTheme: const TextTheme(
      bodyText2: TextStyle(
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    colorScheme: const ColorScheme.dark(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey.shade800,
      elevation: 5,
    ),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade200,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
      ),
    ),
    colorScheme: const ColorScheme.light(),
    textTheme: const TextTheme(
      bodyText2: TextStyle(
        color: Colors.black,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue.shade800,
      elevation: 5,
    ),
  );
}
