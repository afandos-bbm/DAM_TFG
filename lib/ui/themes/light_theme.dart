import 'package:flutter/material.dart';

class LightTheme {
  static const brightness = Brightness.light;
  static const primaryColor = const Color.fromARGB(255, 207, 60, 60);
  static const lightColor = const Color.fromARGB(255, 220, 220, 220);
  static const backgroundColor = const Color.fromARGB(255, 255, 255, 255);
  static const reverseColor = const Color.fromARGB(255, 0, 0, 0);

  static ThemeData getLightTheme() {
    return ThemeData(
        brightness: brightness,
        cardTheme: CardTheme().copyWith(
          elevation: 6,
          shadowColor: Color(Colors.black45.value),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.black12,
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
                        side: BorderSide(color: Colors.black12))))));
  }
}
