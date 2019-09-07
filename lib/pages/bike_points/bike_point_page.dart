import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/scroll_view.dart';

class BikePointPage extends StatefulWidget {
  static const route = '/bike_points/:id';

  final Place bikePoint;

  BikePointPage({
    Key key,
    @required this.bikePoint,
  }) : super(key: key);

  @override
  _BikePointPageState createState() => _BikePointPageState();
}

class _BikePointPageState extends State<BikePointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bikePoint.id),
      ),
      body: BikePointListView(
        context: context,
        bikePoint: widget.bikePoint,
      ),
    );
  }
}
