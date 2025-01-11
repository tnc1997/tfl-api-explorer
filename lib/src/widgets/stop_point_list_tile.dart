import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../routes/stop_points/stop_point_route.dart';
import '../routes/stop_points/stop_points_route.dart';

class StopPointListTile extends StatelessWidget {
  const StopPointListTile({
    super.key,
    required this.stopPoint,
  });

  final StopPoint stopPoint;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        stopPoint.id ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        stopPoint.commonName ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        StopPointRoute(
          id: stopPoint.id!,
        ).go(context);
      },
    );
  }
}
