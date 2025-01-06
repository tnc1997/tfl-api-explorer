import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../pages/stop_points/stop_point_page.dart';

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
        Navigator.of(context).pushNamed(
          StopPointPage.routeName,
          arguments: stopPoint,
        );
      },
    );
  }
}
