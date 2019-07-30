import 'package:flutter/material.dart';

import 'line_disruptions_page.dart';
import 'line_routes_page.dart';
import 'line_statuses_page.dart';

class LinePage extends StatefulWidget {
  static const route = '/lines/:id';

  final String id;

  LinePage({Key key, @required this.id}) : super(key: key);

  @override
  _LinePageState createState() => _LinePageState();
}

class _LinePageState extends State<LinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.http),
            title: Text('Line Disruptions'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LineDisruptionsPage.route,
                arguments: widget.id,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.http),
            title: Text('Line Routes'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LineRoutesPage.route,
                arguments: widget.id,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.http),
            title: Text('Line Statuses'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LineStatusesPage.route,
                arguments: widget.id,
              );
            },
          ),
        ],
      ),
    );
  }
}
