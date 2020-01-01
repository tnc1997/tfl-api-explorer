import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/text.dart';

class BikePointAdditionalPropertiesPage extends StatefulWidget {
  static const route = '/bike_points/:id/additional_properties';

  final Place bikePoint;

  BikePointAdditionalPropertiesPage({
    Key key,
    @required this.bikePoint,
  }) : super(key: key);

  @override
  _BikePointAdditionalPropertiesPageState createState() =>
      _BikePointAdditionalPropertiesPageState();
}

class _BikePointAdditionalPropertiesPageState
    extends State<BikePointAdditionalPropertiesPage> {
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
              widget.bikePoint.additionalProperties[index].key,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: NullableText(
              widget.bikePoint.additionalProperties[index].value,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
        itemCount: widget.bikePoint.additionalProperties.length,
      ),
    );
  }
}
