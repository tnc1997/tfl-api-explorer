import 'package:flutter/material.dart';
import 'package:tfl_api_explorer/src/widgets/drawer.dart' as drawer;

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  HomePage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to the TfL API Explorer'),
      ),
      drawer: drawer.Drawer(),
    );
  }
}
