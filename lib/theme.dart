import 'package:flutter/material.dart';

class AppTheme {
  // 135, 103, 170 to MaterialColor
  static final Map<int, Color> _color = {
    50: const Color.fromRGBO(135, 103, 170, .1),
    100: const Color.fromRGBO(135, 103, 170, .2),
    200: const Color.fromRGBO(135, 103, 170, .3),
    300: const Color.fromRGBO(135, 103, 170, .4),
    400: const Color.fromRGBO(135, 103, 170, .5),
    500: const Color.fromRGBO(135, 103, 170, .6),
    600: const Color.fromRGBO(135, 103, 170, .7),
    700: const Color.fromRGBO(135, 103, 170, .8),
    800: const Color.fromRGBO(135, 103, 170, .9),
    900: const Color.fromRGBO(135, 103, 170, 1),
  };

  MaterialColor mainCustomColor = MaterialColor(0xFF8767AA, _color);

  ThemeData get() {
    return ThemeData(
      primarySwatch: mainCustomColor, // Main Color
    );
  }
}
