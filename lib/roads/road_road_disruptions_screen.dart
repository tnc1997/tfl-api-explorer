import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import 'road_disruption_list_tile.dart';

class RoadRoadDisruptionsScreen extends StatefulWidget {
  const RoadRoadDisruptionsScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<RoadRoadDisruptionsScreen> createState() {
    return _RoadRoadDisruptionsScreenState();
  }
}

class _RoadRoadDisruptionsScreenState extends State<RoadRoadDisruptionsScreen> {
  late final Future<List<RoadDisruption>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Road disruptions'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<RoadDisruption>>(
        future: _future,
        builder: (context, data) {
          if (data != null) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return RoadDisruptionListTile(
                  roadDisruption: data[index],
                );
              },
              itemCount: data.length,
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

    _future = context.read<TflApiClient>().road.disruption([widget.id]);
  }
}
