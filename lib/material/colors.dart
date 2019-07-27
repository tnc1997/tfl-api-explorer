import 'package:flutter/material.dart';

class TflColors {
  TflColors._();

  static const MaterialColor corporateBlue = MaterialColor(
    _corporateBluePrimaryValue,
    <int, Color>{
      50: Color(0xFFE0E3F5),
      100: Color(0xFFB3BAE5),
      200: Color(0xFF808CD4),
      300: Color(0xFF4D5EC2),
      400: Color(0xFF263CB5),
      500: Color(_corporateBluePrimaryValue),
      600: Color(0xFF0016A0),
      700: Color(0xFF001297),
      800: Color(0xFF000E8D),
      900: Color(0xFF00087D),
    },
  );
  static const int _corporateBluePrimaryValue = 0xFF0019A8;

  static const MaterialAccentColor corporateBlueAccent = MaterialAccentColor(
    _corporateBlueAccentValue,
    <int, Color>{
      100: Color(0xFFAAACFF),
      200: Color(_corporateBlueAccentValue),
      400: Color(0xFF4447FF),
      700: Color(0xFF2A2EFF),
    },
  );
  static const int _corporateBlueAccentValue = 0xFF7779FF;

  static const MaterialColor corporateRed = MaterialColor(
    _corporateRedPrimaryValue,
    <int, Color>{
      50: Color(0xFFFBE5E4),
      100: Color(0xFFF5BDBC),
      200: Color(0xFFEE928F),
      300: Color(0xFFE76662),
      400: Color(0xFFE14541),
      500: Color(_corporateRedPrimaryValue),
      600: Color(0xFFD8201B),
      700: Color(0xFFD31B17),
      800: Color(0xFFCE1612),
      900: Color(0xFFC50D0A),
    },
  );
  static const int _corporateRedPrimaryValue = 0xFFDC241F;

  static const MaterialAccentColor corporateRedAccent = MaterialAccentColor(
    _corporateRedAccentValue,
    <int, Color>{
      100: Color(0xFFFFF0F0),
      200: Color(_corporateRedAccentValue),
      400: Color(0xFFFF8B8A),
      700: Color(0xFFFF7270),
    },
  );
  static const int _corporateRedAccentValue = 0xFFFFBDBD;

  static const List<MaterialColor> primaries = <MaterialColor>[
    corporateBlue,
    corporateRed,
  ];

  static const List<MaterialAccentColor> accents = <MaterialAccentColor>[
    corporateBlueAccent,
    corporateRedAccent,
  ];
}
