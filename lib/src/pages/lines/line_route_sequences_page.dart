import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/route_sequence_list_tile.dart';

class LineRouteSequencesPage extends StatelessWidget {
  static const routeName = '/lines/:id/route_sequences';

  LineRouteSequencesPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  Widget build(BuildContext context) {
    final routeSequencesFuture = Provider.of<TflApi>(
      context,
      listen: false,
    ).lines.getRouteSequences(line.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Route sequences'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<RouteSequence>>(
        future: routeSequencesFuture,
        builder: (context, data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return RouteSequenceListTile(
                routeSequence: data[index],
              );
            },
            itemCount: data.length,
          );
        },
      ),
    );
  }
}
