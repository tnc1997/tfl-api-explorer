import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_disruptions_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_routes_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_statuses_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_predictions_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_route_sequences_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_stop_points_page.dart';

class LinePage extends StatelessWidget {
  static const routeName = '/lines/:id';

  LinePage({
    Key? key,
    required this.line,
  }) : super(
          key: key,
        );

  final Line line;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(line.id ?? 'Unknown'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Name'),
            subtitle: Text(
              line.name ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Mode name'),
            subtitle: Text(
              line.modeName ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Line disruptions'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LineLineDisruptionsPage.routeName,
                arguments: line,
              );
            },
          ),
          ListTile(
            title: Text('Line routes'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LineLineRoutesPage.routeName,
                arguments: line,
              );
            },
          ),
          ListTile(
            title: Text('Line statuses'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LineLineStatusesPage.routeName,
                arguments: line,
              );
            },
          ),
          ListTile(
            title: Text('Predictions'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LinePredictionsPage.routeName,
                arguments: line,
              );
            },
          ),
          ListTile(
            title: Text('Route sequences'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LineRouteSequencesPage.routeName,
                arguments: line,
              );
            },
          ),
          ListTile(
            title: Text('Stop points'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LineStopPointsPage.routeName,
                arguments: line,
              );
            },
          ),
        ],
      ),
    );
  }
}
