import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/road_disruptions/road_disruption_page.dart';

class RoadDisruptionListTile extends StatelessWidget {
  RoadDisruptionListTile({
    Key? key,
    required this.roadDisruption,
  }) : super(
          key: key,
        );

  final RoadDisruption roadDisruption;

  @override
  Widget build(BuildContext context) {
    final lastModifiedTime = roadDisruption.lastModifiedTime;

    return ListTile(
      title: Text(
        roadDisruption.category ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: lastModifiedTime != null
          ? Text(
              DateFormat.Hm().format(lastModifiedTime),
            )
          : null,
      onTap: () {
        Navigator.of(context).pushNamed(
          RoadDisruptionPage.routeName,
          arguments: roadDisruption,
        );
      },
    );
  }
}
