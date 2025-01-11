import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class RoadDisruptionPage extends StatelessWidget {
  const RoadDisruptionPage({
    super.key,
    required this.roadDisruption,
  });

  final RoadDisruption roadDisruption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roadDisruption.category ?? 'Unknown'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          roadDisruption.comments ?? 'Unknown',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
