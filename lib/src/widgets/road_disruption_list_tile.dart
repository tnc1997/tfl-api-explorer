import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/road_disruptions/road_disruption_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class RoadDisruptionListTile extends StatelessWidget {
  RoadDisruptionListTile({
    Key key,
    @required this.roadDisruption,
  }) : super(
          key: key,
        );

  final RoadDisruption roadDisruption;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NullableText(
        roadDisruption.category,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        DateFormat.Hm().format(roadDisruption.lastModifiedTime),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          RoadDisruptionPage.routeName,
          arguments: roadDisruption,
        );
      },
    );
  }
}
