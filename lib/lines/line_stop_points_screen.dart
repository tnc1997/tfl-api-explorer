import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import '../stop_points/stop_point_list_tile.dart';

class LineStopPointsScreen extends StatefulWidget {
  const LineStopPointsScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LineStopPointsScreen> createState() {
    return _LineStopPointsScreenState();
  }
}

class _LineStopPointsScreenState extends State<LineStopPointsScreen> {
  late final Future<List<StopPoint>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop points'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: _future,
        builder: (context, data) {
          if (data != null) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return StopPointListTile(
                  stopPoint: data[index],
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

    _future = context.read<TflApiClient>().line.stopPoints(widget.id);
  }
}
