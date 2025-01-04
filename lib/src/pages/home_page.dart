import 'package:flutter/material.dart';
import 'package:tfl_api_explorer/src/widgets/tfl_api_explorer_drawer.dart';

class HomePage extends StatelessWidget {
  static const routeName = Navigator.defaultRouteName;

  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to the TfL API Explorer'),
      ),
      drawer: TflApiExplorerDrawer(),
    );
  }
}
