import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class LineStatusPage extends StatelessWidget {
  const LineStatusPage({
    super.key,
    required this.lineStatus,
  });

  final LineStatus lineStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lineStatus.statusSeverityDescription ?? 'Unknown'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          lineStatus.reason ?? 'Unknown',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
