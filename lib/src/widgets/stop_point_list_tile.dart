import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

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
        context.go('/stop_points/${stopPoint.id}');
      },
    );
  }
}
