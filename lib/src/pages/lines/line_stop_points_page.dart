import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/stop_point_list_tile.dart';

class LineStopPointsPage extends StatelessWidget {
  static const routeName = '/lines/:id/stop_points';

  LineStopPointsPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  Widget build(BuildContext context) {
    final stopPointsFuture = Provider.of<TflApi>(
      context,
      listen: false,
    ).lines.getStopPoints(line.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Stop points'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: stopPointsFuture,
        builder: (context, data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return StopPointListTile(
                stopPoint: data[index],
              );
            },
            itemCount: data.length,
          );
        },
      ),
    );
  }
}
