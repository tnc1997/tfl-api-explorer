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
import 'list_tile.dart';

class LineListView extends ListView {
  LineListView({
    Key key,
    @required BuildContext context,
    @required Line line,
  }) : super(
          key: key,
          children: <Widget>[
            AlignedListTile(
              title: Text('Name'),
              subtitle: NullableText(
                line.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AlignedListTile(
              title: Text('Mode name'),
              subtitle: NullableText(
                line.modeName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Divider(),
            AlignedListTile(
              title: Text('Line disruptions'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  LineLineDisruptionsPage.route,
                  arguments: line,
                );
              },
            ),
            AlignedListTile(
              title: Text('Line routes'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  LineLineRoutesPage.route,
                  arguments: line,
                );
              },
            ),
            AlignedListTile(
              title: Text('Line statuses'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  LineLineStatusesPage.route,
                  arguments: line,
                );
              },
            ),
            AlignedListTile(
              title: Text('Predictions'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  LinePredictionsPage.route,
                  arguments: line,
                );
              },
            ),
            AlignedListTile(
              title: Text('Route sequences'),
              onTap: () {
                Navigator.of(context).pushNamed(
                  LineRouteSequencesPage.route,
                  arguments: line,
                );
              },
            ),
            AlignedListTile(
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
            AlignedListTile(
              title: Text('Origination'),
              subtitle: NullableText(
                lineRoute.originationName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AlignedListTile(
              title: Text('Destination'),
              subtitle: NullableText(
                lineRoute.destinationName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AlignedListTile(
              title: Text('Service type'),
              subtitle: NullableText(
                lineRoute.serviceType,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AlignedListTile(
              title: Text('Valid to'),
              subtitle: DateTimeNullableText(
                lineRoute.validTo,
                overflow: TextOverflow.ellipsis,
                dateFormat: DateFormat.yMMMd(),
              ),
            ),
            AlignedListTile(
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
            AlignedListTile(
              title: Text('Vehicle'),
              subtitle: NullableText(
                prediction.vehicleId,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AlignedListTile(
              title: Text('Station name'),
              subtitle: NullableText(
                prediction.stationName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AlignedListTile(
              title: Text('Line name'),
              subtitle: NullableText(
                prediction.lineName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AlignedListTile(
              title: Text('Platform name'),
              subtitle: NullableText(
                prediction.platformName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AlignedListTile(
              title: Text('Destination name'),
              subtitle: NullableText(
                prediction.destinationName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AlignedListTile(
              title: Text('Current location'),
              subtitle: NullableText(
                prediction.currentLocation,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AlignedListTile(
              title: Text('Towards'),
              subtitle: NullableText(
                prediction.towards,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AlignedListTile(
              title: Text('Expected arrival'),
              subtitle: DateTimeNullableText(
                prediction.expectedArrival,
                overflow: TextOverflow.ellipsis,
                dateFormat: DateFormat.Hm(),
              ),
            ),
            AlignedListTile(
              title: Text('Mode name'),
              subtitle: NullableText(
                prediction.modeName,
                overflow: TextOverflow.ellipsis,
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
            AlignedListTile(
              title: Text('Line name'),
              subtitle: NullableText(
                routeSequence.lineName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AlignedListTile(
              title: Text('Mode'),
              subtitle: NullableText(
                routeSequence.mode,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Divider(),
            AlignedListTile(
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
            AlignedListTile(
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
            AlignedListTile(
              title: Text('Line name'),
              subtitle: NullableText(
                stopPointSequence.lineName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AlignedListTile(
              title: Text('Service type'),
              subtitle: NullableText(
                stopPointSequence.serviceType,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Divider(),
            AlignedListTile(
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
