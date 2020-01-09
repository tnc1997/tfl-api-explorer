import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class BikePointAdditionalPropertiesPage extends StatelessWidget {
  static const routeName = '/bike_points/:id/additional_properties';

  BikePointAdditionalPropertiesPage({
    Key key,
    @required this.bikePoint,
  }) : super(
          key: key,
        );

  final Place bikePoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Additional properties'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: NullableText(
              bikePoint.additionalProperties[index]?.key,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: NullableText(
              bikePoint.additionalProperties[index]?.value,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
        itemCount: bikePoint.additionalProperties?.length,
      ),
    );
  }
}
