import 'package:flutter/material.dart';

import 'line_mode_name_filter_page.dart';

class LineFiltersPage extends StatefulWidget {
  LineFiltersPage({Key key}) : super(key: key);

  @override
  _LineFiltersPageState createState() => _LineFiltersPageState();
}

class _LineFiltersPageState extends State<LineFiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Mode name'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LineModeNameFilterPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
