import 'package:flutter/material.dart';

class AppTheme {
  // F0DCED to MaterialColor
  static final Map<int, Color> _color = {
    50: const Color.fromRGBO(240, 220, 237, .1),
    100: const Color.fromRGBO(240, 220, 237, .2),
    200: const Color.fromRGBO(240, 220, 237, .3),
    300: const Color.fromRGBO(240, 220, 237, .4),
    400: const Color.fromRGBO(240, 220, 237, .5),
    500: const Color.fromRGBO(240, 220, 237, .6),
    600: const Color.fromRGBO(240, 220, 237, .7),
    700: const Color.fromRGBO(240, 220, 237, .8),
    800: const Color.fromRGBO(240, 220, 237, .9),
    900: const Color.fromARGB(255, 231, 175, 223),
  };

  MaterialColor mainCustomColor = MaterialColor(0xFFF1A8E6, _color);

  ThemeData get() {
    return ThemeData(
      primaryColor: mainCustomColor, // Main Color
    );
  }
}
