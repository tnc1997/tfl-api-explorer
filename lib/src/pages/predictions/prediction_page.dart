import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class PredictionPage extends StatelessWidget {
  static const routeName = '/predictions/:id';

  PredictionPage({
    super.key,
    required this.prediction,
  });

  final Prediction prediction;

  @override
  Widget build(BuildContext context) {
    final expectedArrival = prediction.expectedArrival;

    return Scaffold(
      appBar: AppBar(
        title: Text(prediction.id ?? 'Unknown'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Vehicle'),
            subtitle: Text(
              prediction.vehicleId ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Station name'),
            subtitle: Text(
              prediction.stationName ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Line name'),
            subtitle: Text(
              prediction.lineName ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Platform name'),
            subtitle: Text(
              prediction.platformName ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Destination name'),
            subtitle: Text(
              prediction.destinationName ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Current location'),
            subtitle: Text(
              prediction.currentLocation ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Towards'),
            subtitle: Text(
              prediction.towards ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (expectedArrival != null)
            ListTile(
              title: Text('Expected arrival'),
              subtitle: Text(
                DateFormat.Hm().format(expectedArrival),
              ),
            ),
          ListTile(
            title: Text('Mode name'),
            subtitle: Text(
              prediction.modeName ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
