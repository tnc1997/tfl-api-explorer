import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../places/additional_properties_list_tile.dart';

class StopPointAdditionalPropertiesScreen extends StatefulWidget {
  const StopPointAdditionalPropertiesScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<StopPointAdditionalPropertiesScreen> createState() {
    return _StopPointAdditionalPropertiesScreenState();
  }
}

class _StopPointAdditionalPropertiesScreenState
    extends State<StopPointAdditionalPropertiesScreen> {
  late final Future<List<StopPoint>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Additional properties'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: _future,
        builder: (context, data) {
          if (data?[0].additionalProperties case final additionalProperties?) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return AdditionalPropertiesListTile(
                  additionalProperties: additionalProperties[index],
                );
              },
              itemCount: additionalProperties.length,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _future = context.read<TflApiClient>().stopPoint.get([widget.id]);
  }
}
