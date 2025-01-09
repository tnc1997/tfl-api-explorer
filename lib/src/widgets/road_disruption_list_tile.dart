import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../pages/road_disruptions/road_disruption_page.dart';

class RoadDisruptionListTile extends StatelessWidget {
  const RoadDisruptionListTile({
    super.key,
    required this.roadDisruption,
  });

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
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return RoadDisruptionPage(
                roadDisruption: roadDisruption,
              );
            },
          ),
        );
      },
    );
  }
}
