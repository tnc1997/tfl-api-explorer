import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class LineRoutePage extends StatelessWidget {
  static const routeName = '/line_routes/:id';

  LineRoutePage({
    Key? key,
    required this.lineRoute,
  }) : super(
          key: key,
        );

  final MatchedRoute lineRoute;

  @override
  Widget build(BuildContext context) {
    final validTo = lineRoute.validTo;
    final validFrom = lineRoute.validFrom;

    return Scaffold(
      appBar: AppBar(
        title: Text(lineRoute.name ?? 'Unknown'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Origination'),
            subtitle: Text(
              lineRoute.originationName ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Destination'),
            subtitle: Text(
              lineRoute.destinationName ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Service type'),
            subtitle: Text(
              lineRoute.serviceType ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (validTo != null)
            ListTile(
              title: Text('Valid to'),
              subtitle: Text(
                DateFormat.yMMMd().format(validTo),
              ),
            ),
          if (validFrom != null)
            ListTile(
              title: Text('Valid from'),
              subtitle: Text(
                DateFormat.yMMMd().format(validFrom),
              ),
            ),
        ],
      ),
    );
  }
}
