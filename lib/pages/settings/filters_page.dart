import 'package:flutter/material.dart';

import 'line_filters_page.dart';

class FiltersPage extends StatefulWidget {
  FiltersPage({Key key}) : super(key: key);

  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Lines'),
            subtitle: Text('Line routes, predictions'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return LineFiltersPage();
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
