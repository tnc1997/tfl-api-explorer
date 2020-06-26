import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/additional_properties_list_tile.dart';

class CarParkAdditionalPropertiesPage extends StatelessWidget {
  static const routeName = '/car_parks/:id/additional_properties';

  CarParkAdditionalPropertiesPage({
    Key key,
    @required this.carPark,
  }) : super(
          key: key,
        );

  final Place carPark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Additional properties'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return AdditionalPropertiesListTile(
            additionalProperties: carPark.additionalProperties[index],
          );
        },
        itemCount: carPark.additionalProperties.length,
      ),
    );
  }
}