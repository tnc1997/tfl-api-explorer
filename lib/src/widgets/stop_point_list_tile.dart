import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/stop_points/stop_point_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class StopPointListTile extends StatelessWidget {
  StopPointListTile({
    Key key,
    @required this.stopPoint,
  }) : super(
          key: key,
        );

  final StopPoint stopPoint;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NullableText(
        stopPoint.id,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: NullableText(
        stopPoint.commonName,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          StopPointPage.routeName,
          arguments: stopPoint,
        );
      },
    );
  }
}
