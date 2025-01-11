import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import 'stop_point_list_tile.dart';

class StopPointSequenceStopPointsPage extends StatelessWidget {
  const StopPointSequenceStopPointsPage({
    super.key,
    required this.stopPointSequence,
  });

  final StopPointSequence stopPointSequence;

  @override
  Widget build(BuildContext context) {
    final stopPoints = stopPointSequence.stopPoint?.map((matchedStop) {
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
      body: stopPoints != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return StopPointListTile(
                  stopPoint: stopPoints[index],
                );
              },
              itemCount: stopPoints.length,
            )
          : Container(),
    );
  }
}
