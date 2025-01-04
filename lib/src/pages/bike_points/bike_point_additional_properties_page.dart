import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/additional_properties_list_tile.dart';

class BikePointAdditionalPropertiesPage extends StatelessWidget {
  static const routeName = '/bike_points/:id/additional_properties';

  const BikePointAdditionalPropertiesPage({
    super.key,
    required this.bikePoint,
  });

  final Place bikePoint;

  @override
  Widget build(BuildContext context) {
    final additionalProperties = bikePoint.additionalProperties;

    return Scaffold(
      appBar: AppBar(
        title: Text('Additional properties'),
      ),
      body: additionalProperties != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                return AdditionalPropertiesListTile(
                  additionalProperties: additionalProperties[index],
                );
              },
              itemCount: additionalProperties.length,
            )
          : Container(),
    );
  }
}
