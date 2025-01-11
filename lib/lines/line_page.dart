import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/circular_progress_indicator_future_builder.dart';
import 'line_line_disruptions_route.dart';
import 'line_line_routes_route.dart';
import 'line_line_statuses_route.dart';
import 'line_predictions_route.dart';
import 'line_route_sequences_route.dart';
import 'line_stop_points_route.dart';
import 'lines_route.dart';

class LinePage extends StatefulWidget {
  const LinePage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LinePage> createState() {
    return _LinePageState();
  }
}

class _LinePageState extends State<LinePage> {
  late final Future<List<Line>> _future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<Line>>(
        future: _future,
        builder: (context, data) {
          if (data != null) {
            return ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(
                    data[0].name ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ListTile(
                  title: Text('Mode name'),
                  subtitle: Text(
                    data[0].modeName ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Line disruptions'),
                  onTap: () {
                    LineLineDisruptionsRoute(
                      id: widget.id,
                    ).go(context);
                  },
                ),
                ListTile(
                  title: Text('Line routes'),
                  onTap: () {
                    LineLineRoutesRoute(
                      id: widget.id,
                    ).go(context);
                  },
                ),
                ListTile(
                  title: Text('Line statuses'),
                  onTap: () {
                    LineLineStatusesRoute(
                      id: widget.id,
                    ).go(context);
                  },
                ),
                ListTile(
                  title: Text('Predictions'),
                  onTap: () {
                    LinePredictionsRoute(
                      id: widget.id,
                    ).go(context);
                  },
                ),
                ListTile(
                  title: Text('Route sequences'),
                  onTap: () {
                    LineRouteSequencesRoute(
                      id: widget.id,
                    ).go(context);
                  },
                ),
                ListTile(
                  title: Text('Stop points'),
                  onTap: () {
                    LineStopPointsRoute(
                      id: widget.id,
                    ).go(context);
                  },
                ),
              ],
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

    _future = context.read<TflApiClient>().line.get([widget.id]);
  }
}
