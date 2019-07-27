import 'package:flutter/material.dart';

import 'material/colors.dart';
import 'pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      title: 'TfL API Explorer',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: TflColors.corporateBlue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: TflColors.corporateBlue,
      ),
      supportedLocales: [const Locale('en', 'GB')],
    );
  }
}
