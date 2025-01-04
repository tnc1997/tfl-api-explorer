import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class LineDisruptionPage extends StatelessWidget {
  static const routeName = '/line_disruptions/:id';

  LineDisruptionPage({
    super.key,
    required this.lineDisruption,
  });

  final Disruption lineDisruption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lineDisruption.categoryDescription ?? 'Unknown'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          lineDisruption.description ?? 'Unknown',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
