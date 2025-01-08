import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../widgets/circular_progress_indicator_future_builder.dart';
import 'line_line_disruptions_page.dart';
import 'line_line_routes_page.dart';
import 'line_line_statuses_page.dart';
import 'line_predictions_page.dart';
import 'line_route_sequences_page.dart';
import 'line_stop_points_page.dart';

class LinePage extends StatefulWidget {
  static const routeName = '/lines/:id';

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
                    Navigator.of(context).pushNamed(
                      LineLineDisruptionsPage.routeName,
                      arguments: widget.id,
                    );
                  },
                ),
                ListTile(
                  title: Text('Line routes'),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      LineLineRoutesPage.routeName,
                      arguments: widget.id,
                    );
                  },
                ),
                ListTile(
                  title: Text('Line statuses'),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      LineLineStatusesPage.routeName,
                      arguments: widget.id,
                    );
                  },
                ),
                ListTile(
                  title: Text('Predictions'),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      LinePredictionsPage.routeName,
                      arguments: widget.id,
                    );
                  },
                ),
                ListTile(
                  title: Text('Route sequences'),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      LineRouteSequencesPage.routeName,
                      arguments: widget.id,
                    );
                  },
                ),
                ListTile(
                  title: Text('Stop points'),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      LineStopPointsPage.routeName,
                      arguments: widget.id,
                    );
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
