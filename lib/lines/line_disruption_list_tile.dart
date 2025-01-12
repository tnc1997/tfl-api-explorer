import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import 'line_disruption_screen.dart';

class LineDisruptionListTile extends StatelessWidget {
  const LineDisruptionListTile({
    super.key,
    required this.lineDisruption,
  });

  final Disruption lineDisruption;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        lineDisruption.categoryDescription ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        DateFormat.Hm().format(
          lineDisruption.lastUpdate ?? lineDisruption.created ?? DateTime.now(),
        ),
      ),
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return LineDisruptionScreen(
                lineDisruption: lineDisruption,
              );
            },
          ),
        );
      },
    );
  }
}
