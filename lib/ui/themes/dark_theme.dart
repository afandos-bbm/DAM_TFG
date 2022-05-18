import 'package:flutter/material.dart';

class DarkTheme {
  static const brightness = Brightness.dark;
  static const primaryColor = const Color.fromARGB(255, 207, 60, 60);
  static const lightColor = const Color.fromARGB(255, 100, 100, 100);
  static const backgroundColor = const Color.fromARGB(255, 0, 0, 0);
  static const reverseColor = const Color.fromARGB(255, 255, 255, 255);

  static ThemeData getDarkTheme() {
    return ThemeData(
        brightness: brightness,
        cardTheme: CardTheme().copyWith(
          elevation: 5,
          shadowColor: Color(Colors.white12.value),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.white12,
            ),
          ),
        ),
        listTileTheme: ListTileThemeData().copyWith(
          dense: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.white12))))));
  }
}
