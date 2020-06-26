import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/stop_point_list_tile.dart';

class LineStopPointsPage extends StatefulWidget {
  static const routeName = '/lines/:id/stop_points';

  LineStopPointsPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  _LineStopPointsPageState createState() => _LineStopPointsPageState();
}

class _LineStopPointsPageState extends State<LineStopPointsPage> {
  Future<List<StopPoint>> _stopPointsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop points'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: _stopPointsFuture,
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

  @override
  void initState() {
    super.initState();

    _stopPointsFuture =
        context.read<TflApi>().lines.getStopPoints(widget.line.id);
  }
}
