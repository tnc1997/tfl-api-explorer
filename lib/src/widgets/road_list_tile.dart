import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class RoadListTile extends StatelessWidget {
  RoadListTile({
    Key? key,
    required this.road,
    this.onTap,
  }) : super(
          key: key,
        );

  final RoadCorridor road;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        road.id ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        road.displayName ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}
