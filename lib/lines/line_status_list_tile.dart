import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import 'line_status_screen.dart';

class LineStatusListTile extends StatelessWidget {
  const LineStatusListTile({
    super.key,
    required this.lineStatus,
  });

  final LineStatus lineStatus;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        lineStatus.statusSeverityDescription ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        lineStatus.disruption?.categoryDescription ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return LineStatusScreen(
                lineStatus: lineStatus,
              );
            },
          ),
        );
      },
    );
  }
}
