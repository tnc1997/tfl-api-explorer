import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/line_statuses/line_status_page.dart';

class LineStatusListTile extends StatelessWidget {
  LineStatusListTile({
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
      onTap: () {
        Navigator.of(context).pushNamed(
          LineStatusPage.routeName,
          arguments: lineStatus,
        );
      },
    );
  }
}
