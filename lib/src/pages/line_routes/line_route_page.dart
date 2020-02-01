import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LineRoutePage extends StatelessWidget {
  static const routeName = '/line_routes/:id';

  LineRoutePage({
    Key key,
    @required this.lineRoute,
  }) : super(
          key: key,
        );

  final LineRoute lineRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lineRoute.name),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Origination'),
            subtitle: NullableText(
              lineRoute.originationName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Destination'),
            subtitle: NullableText(
              lineRoute.destinationName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Service type'),
            subtitle: NullableText(
              lineRoute.serviceType,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Valid to'),
            subtitle: Text(
              DateFormat.yMMMd().format(
                lineRoute.validTo,
              ),
            ),
          ),
          ListTile(
            title: Text('Valid from'),
            subtitle: Text(
              DateFormat.yMMMd().format(
                lineRoute.validFrom,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
