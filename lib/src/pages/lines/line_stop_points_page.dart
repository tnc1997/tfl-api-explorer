import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../widgets/circular_progress_indicator_future_builder.dart';
import '../../widgets/stop_point_list_tile.dart';

class LineStopPointsPage extends StatefulWidget {
  static const routeName = '/lines/:id/stop_points';

  const LineStopPointsPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LineStopPointsPage> createState() {
    return _LineStopPointsPageState();
  }
}

class _LineStopPointsPageState extends State<LineStopPointsPage> {
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
