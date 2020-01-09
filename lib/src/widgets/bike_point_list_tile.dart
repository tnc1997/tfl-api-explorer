import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/bike_points/bike_point_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class BikePointListTile extends StatelessWidget {
  BikePointListTile({
    Key key,
    @required this.bikePoint,
  }) : super(
          key: key,
        );

  final Place bikePoint;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NullableText(
        bikePoint.id,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: NullableText(
        bikePoint.commonName,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          BikePointPage.routeName,
          arguments: bikePoint,
        );
      },
    );
  }
}
