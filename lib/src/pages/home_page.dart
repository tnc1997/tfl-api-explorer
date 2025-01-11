import 'package:flutter/material.dart';

import '../../common/drawer.dart';

class HomePage extends StatelessWidget {
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
        child: Text('Welcome to Explorer for TfL API'),
      ),
      drawer: TflApiExplorerDrawer(),
    );
  }
}
