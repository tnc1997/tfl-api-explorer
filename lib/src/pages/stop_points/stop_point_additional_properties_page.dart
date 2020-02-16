import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class StopPointAdditionalPropertiesPage extends StatelessWidget {
  static const routeName = '/stop_points/:id/additional_properties';

  StopPointAdditionalPropertiesPage({
    Key key,
    @required this.stopPoint,
  }) : super(
          key: key,
        );

  final StopPoint stopPoint;

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
              stopPoint.additionalProperties[index]?.key,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: NullableText(
              stopPoint.additionalProperties[index]?.value,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
        itemCount: stopPoint.additionalProperties?.length,
      ),
    );
  }
}
