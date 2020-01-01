import 'package:flutter/material.dart';
import 'package:tfl_api_explorer/src/material/drawer.dart';

class HomePage extends StatefulWidget {
  static const route = '/home';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to the TfL API Explorer'),
      ),
      drawer: AppDrawer(),
    );
  }
}
