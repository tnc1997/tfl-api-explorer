import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_disruptions_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_routes_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_line_statuses_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_predictions_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_route_sequences_page.dart';
import 'package:tfl_api_explorer/src/pages/lines/line_stop_points_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LinePage extends StatefulWidget {
  static const route = '/lines/:id';

  final Line line;

  LinePage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  @override
  _LinePageState createState() => _LinePageState();
}

class _LinePageState extends State<LinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.line.id),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Name'),
            subtitle: NullableText(
              widget.line.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Mode name'),
            subtitle: NullableText(
              widget.line.modeName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Line disruptions'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LineLineDisruptionsPage.route,
                arguments: widget.line,
              );
            },
          ),
          ListTile(
            title: Text('Line routes'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LineLineRoutesPage.route,
                arguments: widget.line,
              );
            },
          ),
          ListTile(
            title: Text('Line statuses'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LineLineStatusesPage.route,
                arguments: widget.line,
              );
            },
          ),
          ListTile(
            title: Text('Predictions'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LinePredictionsPage.route,
                arguments: widget.line,
              );
            },
          ),
          ListTile(
            title: Text('Route sequences'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LineRouteSequencesPage.route,
                arguments: widget.line,
              );
            },
          ),
          ListTile(
            title: Text('Stop points'),
            onTap: () {
              Navigator.of(context).pushNamed(
                LineStopPointsPage.route,
                arguments: widget.line,
              );
            },
          ),
        ],
      ),
    );
  }
}
