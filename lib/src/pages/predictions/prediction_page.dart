import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class PredictionPage extends StatelessWidget {
  static const routeName = '/predictions/:id';

  PredictionPage({
    Key key,
    @required this.prediction,
  }) : super(
          key: key,
        );

  final Prediction prediction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(prediction.id),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Vehicle'),
            subtitle: NullableText(
              prediction.vehicleId,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Station name'),
            subtitle: NullableText(
              prediction.stationName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Line name'),
            subtitle: NullableText(
              prediction.lineName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Platform name'),
            subtitle: NullableText(
              prediction.platformName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Destination name'),
            subtitle: NullableText(
              prediction.destinationName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Current location'),
            subtitle: NullableText(
              prediction.currentLocation,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Towards'),
            subtitle: NullableText(
              prediction.towards,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Expected arrival'),
            subtitle: Text(
              DateFormat.Hm().format(
                prediction.expectedArrival,
              ),
            ),
          ),
          ListTile(
            title: Text('Mode name'),
            subtitle: NullableText(
              prediction.modeName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
