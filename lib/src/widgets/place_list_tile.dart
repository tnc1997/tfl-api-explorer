import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class PlaceListTile extends StatelessWidget {
  PlaceListTile({
    Key? key,
    required this.place,
    this.onTap,
  }) : super(
          key: key,
        );

  final Place place;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        place.id ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        place.commonName ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}
