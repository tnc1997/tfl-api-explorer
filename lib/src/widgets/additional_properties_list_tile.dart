import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class AdditionalPropertiesListTile extends StatelessWidget {
  AdditionalPropertiesListTile({
    Key key,
    @required this.additionalProperties,
  }) : super(
          key: key,
        );

  final AdditionalProperties additionalProperties;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NullableText(
        additionalProperties.key,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: NullableText(
        additionalProperties.value,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
