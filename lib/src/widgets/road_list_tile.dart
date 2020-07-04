import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class RoadListTile extends StatelessWidget {
  RoadListTile({
    Key key,
    @required this.road,
    this.onTap,
  }) : super(
          key: key,
        );

  final Road road;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NullableText(
        road.id,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: NullableText(
        road.displayName,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}
