import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../src/widgets/additional_properties_list_tile.dart';

class BikePointAdditionalPropertiesPage extends StatefulWidget {
  const BikePointAdditionalPropertiesPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<BikePointAdditionalPropertiesPage> createState() {
    return _BikePointAdditionalPropertiesPageState();
  }
}

class _BikePointAdditionalPropertiesPageState
    extends State<BikePointAdditionalPropertiesPage> {
  late final Future<Place> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Additional properties'),
      ),
      body: CircularProgressIndicatorFutureBuilder<Place>(
        future: _future,
        builder: (context, data) {
          if (data?.additionalProperties case final additionalProperties?) {
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

    _future = context.read<TflApiClient>().bikePoint.get(widget.id);
  }
}
