import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class RoadDisruptionPage extends StatelessWidget {
  static const routeName = '/road_disruptions/:id';

  RoadDisruptionPage({
    Key? key,
    required this.roadDisruption,
  }) : super(
          key: key,
        );

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
