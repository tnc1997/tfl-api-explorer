import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../widgets/text.dart';

class LineRouteListView extends ListView {
  LineRouteListView({
    Key key,
    @required LineRoute lineRoute,
  }) : super(
          key: key,
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
              subtitle: DateTimeNullableText(
                lineRoute.validTo,
                overflow: TextOverflow.ellipsis,
                dateFormat: DateFormat.yMMMd(),
              ),
            ),
            ListTile(
              title: Text('Valid from'),
              subtitle: DateTimeNullableText(
                lineRoute.validFrom,
                overflow: TextOverflow.ellipsis,
                dateFormat: DateFormat.yMMMd(),
              ),
            ),
          ],
        );
}

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
              subtitle: DateTimeNullableText(
                prediction.expectedArrival,
                overflow: TextOverflow.ellipsis,
                dateFormat: DateFormat.Hm(),
              ),
            ),
          ],
        );
}
