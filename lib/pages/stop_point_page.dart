import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../material/scroll_view.dart';

class StopPointPage extends StatefulWidget {
  static const route = '/stop_points/:id';

  final StopPoint stopPoint;

  StopPointPage({
    Key key,
    @required this.stopPoint,
  }) : super(key: key);

  @override
  _StopPointPageState createState() => _StopPointPageState();
}

class _StopPointPageState extends State<StopPointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.stopPoint.id),
      ),
      body: StopPointListView(
        context: context,
        stopPoint: widget.stopPoint,
      ),
    );
  }
}
