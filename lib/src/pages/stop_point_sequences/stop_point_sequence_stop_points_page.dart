import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/stop_point_list_tile.dart';

class StopPointSequenceStopPointsPage extends StatelessWidget {
  static const routeName = '/stop_point_sequences/:id/stop_points';

  StopPointSequenceStopPointsPage({
    Key key,
    @required this.stopPointSequence,
  }) : super(
          key: key,
        );

  final StopPointSequence stopPointSequence;

  @override
  Widget build(BuildContext context) {
    final stopPoints = stopPointSequence.stopPoint.map((matchedStop) {
      return StopPoint(
        id: matchedStop.id,
        url: matchedStop.url,
        commonName: matchedStop.name,
        lat: matchedStop.lat,
        lon: matchedStop.lon,
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
