import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class PredictionPage extends StatefulWidget {
  static const route = '/predictions/:id';

  final Prediction prediction;

  PredictionPage({
    Key key,
    @required this.prediction,
  }) : super(
          key: key,
        );

  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.prediction.id),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Vehicle'),
            subtitle: NullableText(
              widget.prediction.vehicleId,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Station name'),
            subtitle: NullableText(
              widget.prediction.stationName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Line name'),
            subtitle: NullableText(
              widget.prediction.lineName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Platform name'),
            subtitle: NullableText(
              widget.prediction.platformName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Destination name'),
            subtitle: NullableText(
              widget.prediction.destinationName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Current location'),
            subtitle: NullableText(
              widget.prediction.currentLocation,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Towards'),
            subtitle: NullableText(
              widget.prediction.towards,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
            title: Text('Expected arrival'),
            subtitle: Text(
              DateFormat.Hm().format(
                widget.prediction.expectedArrival,
              ),
            ),
          ),
          ListTile(
            title: Text('Mode name'),
            subtitle: NullableText(
              widget.prediction.modeName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
