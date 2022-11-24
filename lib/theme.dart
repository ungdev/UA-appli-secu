import 'package:flutter/material.dart';

class AppTheme {
  // F0DCED to MaterialColor
  static final Map<int, Color> _color = {
    50: Color.fromRGBO(240, 220, 237, .1),
    100: Color.fromRGBO(240, 220, 237, .2),
    200: Color.fromRGBO(240, 220, 237, .3),
    300: Color.fromRGBO(240, 220, 237, .4),
    400: Color.fromRGBO(240, 220, 237, .5),
    500: Color.fromRGBO(240, 220, 237, .6),
    600: Color.fromRGBO(240, 220, 237, .7),
    700: Color.fromRGBO(240, 220, 237, .8),
    800: Color.fromRGBO(240, 220, 237, .9),
    900: Color.fromARGB(255, 231, 175, 223),
  };

  MaterialColor mainCustomColor = MaterialColor(0xFFF1A8E6, _color);

  ThemeData get() {
    return ThemeData(
      primaryColor: mainCustomColor, // Main Color
    );
  }
}
