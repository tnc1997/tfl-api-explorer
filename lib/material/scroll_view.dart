import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../pages/lines/line_line_disruptions_page.dart';
import '../pages/lines/line_line_routes_page.dart';
import '../pages/lines/line_line_statuses_page.dart';
import '../pages/lines/line_predictions_page.dart';
import '../pages/lines/line_route_sequences_page.dart';
import '../pages/lines/line_stop_points_page.dart';
import '../pages/route_sequences/route_sequence_stop_point_sequences_page.dart';
import '../pages/stop_point_sequences/stop_point_sequence_stop_points_page.dart';
import '../widgets/text.dart';

class LineListView extends ListView {
  LineListView({
    Key key,
    @required BuildContext context,
    @required Line line,
  }) : super(
          key: key,
          children: <Widget>[
            ListTile(
              title: Text('Name'),
              subtitle: NullableText(
                line.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ListTile(
              title: Text('Mode'),
              subtitle: NullableText(
                line.modeName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.http),
              title: Text('Line disruptions'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  LineLineDisruptionsPage.route,
                  arguments: line,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.http),
              title: Text('Line routes'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  LineLineRoutesPage.route,
                  arguments: line,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.http),
              title: Text('Line statuses'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  LineLineStatusesPage.route,
                  arguments: line,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.http),
              title: Text('Predictions'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  LinePredictionsPage.route,
                  arguments: line,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.http),
              title: Text('Route sequences'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  LineRouteSequencesPage.route,
                  arguments: line,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.http),
              title: Text('Stop points'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  LineStopPointsPage.route,
                  arguments: line,
                );
              },
            ),
          ],
        );
}

class LineRouteListView extends ListView {
  LineRouteListView({
    Key key,
    @required BuildContext context,
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
    @required BuildContext context,
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

class RouteSequenceListView extends ListView {
  RouteSequenceListView({
    Key key,
    @required BuildContext context,
    @required RouteSequence routeSequence,
  }) : super(
          key: key,
          children: <Widget>[
            ListTile(
              title: Text('Line'),
              subtitle: NullableText(
                routeSequence.lineName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ListTile(
              title: Text('Mode'),
              subtitle: NullableText(
                routeSequence.mode,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.http),
              title: Text('Stop point sequences'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  RouteSequenceStopPointSequencesPage.route,
                  arguments: routeSequence,
                );
              },
            ),
          ],
        );
}

class StopPointListView extends ListView {
  StopPointListView({
    Key key,
    @required BuildContext context,
    @required StopPoint stopPoint,
  }) : super(
          key: key,
          children: <Widget>[
            ListTile(
              title: Text('Name'),
              subtitle: NullableText(
                stopPoint.commonName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
}

class StopPointSequenceListView extends ListView {
  StopPointSequenceListView({
    Key key,
    @required BuildContext context,
    @required StopPointSequence stopPointSequence,
  }) : super(
          key: key,
          children: <Widget>[
            ListTile(
              title: Text('Line'),
              subtitle: NullableText(
                stopPointSequence.lineName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ListTile(
              title: Text('Service type'),
              subtitle: NullableText(
                stopPointSequence.serviceType,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.http),
              title: Text('Stop points'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  StopPointSequenceStopPointsPage.route,
                  arguments: stopPointSequence,
                );
              },
            ),
          ],
        );
}
