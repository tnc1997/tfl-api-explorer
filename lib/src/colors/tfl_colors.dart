import 'package:flutter/material.dart';

class TflColors {
  static const blue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFFE4EBF2),
      100: Color(0xFFBACEDE),
      200: Color(0xFF8DADC9),
      300: Color(0xFF5F8CB3),
      400: Color(0xFF3C73A2),
      500: Color(_bluePrimaryValue),
      600: Color(0xFF17528A),
      700: Color(0xFF13487F),
      800: Color(0xFF0F3F75),
      900: Color(0xFF082E63),
    },
  );
  static const _bluePrimaryValue = 0xFF1A5A92;

  static const blueAccent = MaterialAccentColor(
    _blueAccentValue,
    <int, Color>{
      100: Color(0xFF95BBFF),
      200: Color(_blueAccentValue),
      400: Color(0xFF2F79FF),
      700: Color(0xFF1569FF),
    },
  );
  static const _blueAccentValue = 0xFF629AFF;

  static const blueGrey = MaterialColor(
    _blueGreyPrimaryValue,
    <int, Color>{
      50: Color(0xFFE6E6E7),
      100: Color(0xFFC0C1C4),
      200: Color(0xFF96989C),
      300: Color(0xFF6C6E74),
      400: Color(0xFF4D4F57),
      500: Color(_blueGreyPrimaryValue),
      600: Color(0xFF282B33),
      700: Color(0xFF22242C),
      800: Color(0xFF1C1E24),
      900: Color(0xFF111317),
    },
  );
  static const _blueGreyPrimaryValue = 0xFF2D3039;

  static const blueGreyAccent = MaterialAccentColor(
    _blueGreyAccentValue,
    <int, Color>{
      100: Color(0xFF5D9EFF),
      200: Color(_blueGreyAccentValue),
      400: Color(0xFF0062F6),
      700: Color(0xFF0058DC),
    },
  );
  static const _blueGreyAccentValue = 0xFF2A7FFF;

  static const red = MaterialColor(
    _redPrimaryValue,
    <int, Color>{
      50: Color(0xFFFBE5E4),
      100: Color(0xFFF5BDBC),
      200: Color(0xFFEE928F),
      300: Color(0xFFE76662),
      400: Color(0xFFE14541),
      500: Color(_redPrimaryValue),
      600: Color(0xFFD8201B),
      700: Color(0xFFD31B17),
      800: Color(0xFFCE1612),
      900: Color(0xFFC50D0A),
    },
  );
  static const _redPrimaryValue = 0xFFDC241F;

  static const MaterialAccentColor redAccent = MaterialAccentColor(
    _redAccentValue,
    <int, Color>{
      100: Color(0xFFFFF0F0),
      200: Color(_redAccentValue),
      400: Color(0xFFFF8B8A),
      700: Color(0xFFFF7270),
    },
  );
  static const _redAccentValue = 0xFFFFBDBD;

  static const turquoise = MaterialColor(
    _turquoisePrimaryValue,
    <int, Color>{
      50: Color(0xFFEDF9F9),
      100: Color(0xFFD1F0F0),
      200: Color(0xFFB3E6E6),
      300: Color(0xFF94DBDB),
      400: Color(0xFF7DD4D4),
      500: Color(_turquoisePrimaryValue),
      600: Color(0xFF5EC7C7),
      700: Color(0xFF53C0C0),
      800: Color(0xFF49B9B9),
      900: Color(0xFF38ADAD),
    },
  );
  static const _turquoisePrimaryValue = 0xFF66CCCC;

  static const turquoiseAccent = MaterialAccentColor(
    _turquoiseAccentValue,
    <int, Color>{
      100: Color(0xFFF9FFFF),
      200: Color(_turquoiseAccentValue),
      400: Color(0xFF93FFFF),
      700: Color(0xFF7AFFFF),
    },
  );
  static const _turquoiseAccentValue = 0xFFC6FFFF;

  static const List<MaterialColor> primaries = <MaterialColor>[
    blue,
    blueGrey,
    red,
    turquoise,
  ];

  static const List<MaterialAccentColor> accents = <MaterialAccentColor>[
    blueAccent,
    blueGreyAccent,
    redAccent,
    turquoiseAccent,
  ];
}
