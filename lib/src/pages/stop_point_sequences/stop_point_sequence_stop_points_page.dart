import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/stop_point_list_tile.dart';

class StopPointSequenceStopPointsPage extends StatefulWidget {
  static const route = '/stop_point_sequences/:id/stop_points';

  final StopPointSequence stopPointSequence;

  StopPointSequenceStopPointsPage({
    Key key,
    @required this.stopPointSequence,
  }) : super(
          key: key,
        );

  @override
  _StopPointSequenceStopPointsPageState createState() =>
      _StopPointSequenceStopPointsPageState();
}

class _StopPointSequenceStopPointsPageState
    extends State<StopPointSequenceStopPointsPage> {
  @override
  Widget build(BuildContext context) {
    final stopPoints = widget.stopPointSequence.stopPoint.map((stopPoint) {
      return StopPoint(
        id: stopPoint.id,
        url: stopPoint.url,
        commonName: stopPoint.name,
        lat: stopPoint.lat,
        lon: stopPoint.lon,
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Stop points'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return StopPointListTile(
            stopPoint: stopPoints[index],
          );
        },
        itemCount: stopPoints.length,
      ),
    );
  }
}
