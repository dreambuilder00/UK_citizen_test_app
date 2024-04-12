import 'package:flutter/material.dart';

class ThemeColors {
  static const Color background = Color(0xffedf3ff);
  static const Color primary = Color(0xffc8102e);
  static const Color secondary = Color(0xff012169);
  static const Color label = Color(0xFFFFFFFF);
  static const Color border = Color(0xFF3E3E3E);
  static const Color success = Color(0xFF2A9918);
  static const Color successProgressbar = Color(0xFFA2DC5F);
  static const Color failedProgressbar = Color(0xFFF59304);
  static const Color progressBar = Color(0x7FD1D9E6);
  static const Color progress = Color.fromARGB(128, 1, 33, 105);
  static const Color failed = Color(0xffc8102e);


  static const Gradient gradient1 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0x4c012169),
      Color(0x4cffffff),
      Color(0x4cffffff),
      Color(0x4cc8102e),
    ],
  );
  static const Gradient gradient2 = LinearGradient(
    begin: Alignment(-0.98, 0.21),
    end: Alignment(0.98, -0.21),
    colors: [
      Color(0x4C012169),
      Color.fromRGBO(255, 255, 255, 0.3),
      Color.fromRGBO(255, 255, 255, 0.3),
    ],
  );
  static const Gradient gradient3 = LinearGradient(
    begin: Alignment(0, 0.51),
    end: Alignment(0.9, 0),
    colors: [
      Color(0x4cffffff),
      Color(0x33FF0000),
    ],
  );
  static const Gradient gradient4 = LinearGradient(
    begin: Alignment(0.00, -1.00),
      end: Alignment(0, 1),
    colors: [Color(0xff424242), Color(0xFF191919)],
  );
  static const Gradient gradient5 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(0, 66, 66, 66),
      Color.fromARGB(0, 25, 25, 25),
      Color.fromARGB(0, 25, 25, 25),
    ],
  );
}
