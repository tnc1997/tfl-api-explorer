import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LineRoutePage extends StatefulWidget {
  static const route = '/line_routes/:id';

  final LineRoute lineRoute;

  LineRoutePage({
    Key key,
    @required this.lineRoute,
  }) : super(
          key: key,
        );

  @override
  _LineRoutePageState createState() => _LineRoutePageState();
}

class _LineRoutePageState extends State<LineRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lineRoute.name),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Origination'),
            subtitle: NullableText(
              widget.lineRoute.originationName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Destination'),
            subtitle: NullableText(
              widget.lineRoute.destinationName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Service type'),
            subtitle: NullableText(
              widget.lineRoute.serviceType,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Valid to'),
            subtitle: Text(
              DateFormat.yMMMd().format(
                widget.lineRoute.validTo,
              ),
            ),
          ),
          ListTile(
            title: Text('Valid from'),
            subtitle: Text(
              DateFormat.yMMMd().format(
                widget.lineRoute.validFrom,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
