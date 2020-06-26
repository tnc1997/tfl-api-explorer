import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class PlaceListTile extends StatelessWidget {
  PlaceListTile({
    Key key,
    @required this.place,
    this.onTap,
  }) : super(
          key: key,
        );

  final Place place;
  
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NullableText(
        place.id,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: NullableText(
        place.commonName,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}
