import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import 'line_prediction_destination_name_filter_page.dart';
import 'line_prediction_station_name_filter_page.dart';

class LinePredictionFiltersPage extends StatefulWidget {
  final Line line;

  LinePredictionFiltersPage({
    Key key,
    @required this.line,
  }) : super(key: key);

  @override
  _LinePredictionFiltersPageState createState() =>
      _LinePredictionFiltersPageState();
}

class _LinePredictionFiltersPageState extends State<LinePredictionFiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Station name'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LinePredictionStationNameFilterPage(
                      line: widget.line,
                    );
                  },
                ),
              );
            },
          ),
          ListTile(
            title: Text('Destination name'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LinePredictionDestinationNameFilterPage(
                      line: widget.line,
                    );
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
