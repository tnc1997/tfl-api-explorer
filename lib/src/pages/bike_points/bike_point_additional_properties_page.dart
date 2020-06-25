import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/additional_properties_list_tile.dart';

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
          return AdditionalPropertiesListTile(
            additionalProperties: bikePoint.additionalProperties[index],
          );
        },
        itemCount: bikePoint.additionalProperties.length,
      ),
    );
  }
}
