import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../widgets/text.dart';

class PredictionListView extends ListView {
  PredictionListView({
    Key key,
    @required Prediction prediction,
  }) : super(
          key: key,
          children: <Widget>[
            ListTile(
              title: Text('Vehicle'),
              subtitle: NullableText(
                prediction.vehicleId,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ListTile(
              title: Text('Stop point'),
              subtitle: NullableText(
                prediction.stationName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ListTile(
              title: Text('Platform'),
              subtitle: NullableText(
                prediction.platformName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ListTile(
              title: Text('Destination'),
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
              subtitle: NullableText(
                DateFormat.Hm().format(prediction.expectedArrival),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
}
