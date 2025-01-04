import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/route_sequence_list_tile.dart';

class LineRouteSequencesPage extends StatefulWidget {
  static const routeName = '/lines/:id/route_sequences';

  const LineRouteSequencesPage({
    super.key,
    required this.line,
  });

  final Line line;

  @override
  _LineRouteSequencesPageState createState() => _LineRouteSequencesPageState();
}

class _LineRouteSequencesPageState extends State<LineRouteSequencesPage> {
  late Future<List<RouteSequence>> _routeSequencesFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route sequences'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<RouteSequence>>(
        future: _routeSequencesFuture,
        builder: (context, data) {
          if (data != null) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return RouteSequenceListTile(
                  routeSequence: data[index],
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

    _routeSequencesFuture = context
        .read<TflApiClient>()
        .line
        .routeSequence(widget.line.id!, 'inbound')
        .then((value) => [value]);
  }
}
