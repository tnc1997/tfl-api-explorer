import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class RoadDisruptionPage extends StatelessWidget {
  static const routeName = '/road_disruptions/:id';

  RoadDisruptionPage({
    Key key,
    @required this.roadDisruption,
  }) : super(
          key: key,
        );

  final RoadDisruption roadDisruption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roadDisruption.category),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NullableText(
          roadDisruption.comments,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
