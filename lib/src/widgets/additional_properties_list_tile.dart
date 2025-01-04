import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class AdditionalPropertiesListTile extends StatelessWidget {
  const AdditionalPropertiesListTile({
    super.key,
    required this.additionalProperties,
  });

  final AdditionalProperties additionalProperties;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        additionalProperties.key ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        additionalProperties.value ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
