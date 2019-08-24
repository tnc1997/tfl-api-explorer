import 'package:flutter/material.dart';

import 'line_line_route_service_type_filter_page.dart';

class LineLineRouteFiltersPage extends StatefulWidget {
  LineLineRouteFiltersPage({Key key}) : super(key: key);

  @override
  _LineLineRouteFiltersPageState createState() =>
      _LineLineRouteFiltersPageState();
}

class _LineLineRouteFiltersPageState extends State<LineLineRouteFiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Service type'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LineLineRouteServiceTypeFilterPage();
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
