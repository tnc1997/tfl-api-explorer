import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/additional_properties_list_tile.dart';

class StopPointAdditionalPropertiesPage extends StatelessWidget {
  static const routeName = '/stop_points/:id/additional_properties';

  StopPointAdditionalPropertiesPage({
    Key? key,
    required this.stopPoint,
  }) : super(
          key: key,
        );

  final StopPoint stopPoint;

  @override
  Widget build(BuildContext context) {
    final additionalProperties = stopPoint.additionalProperties;

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
