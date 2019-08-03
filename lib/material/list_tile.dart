import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart' as tflApiClient;

import '../pages/line_disruption_page.dart';
import '../pages/line_page.dart';
import '../pages/line_route_page.dart';
import '../pages/line_status_page.dart';
import '../pages/prediction_page.dart';
import '../widgets/text.dart';

class LineDisruptionListTile extends ListTile {
  LineDisruptionListTile({
    Key key,
    @required BuildContext context,
    @required tflApiClient.LineDisruption lineDisruption,
  }) : super(
          key: key,
          title: NullableText(
            lineDisruption.categoryDescription,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: DateTimeNullableText(
            lineDisruption.lastUpdate ?? lineDisruption.created,
            overflow: TextOverflow.ellipsis,
            dateFormat: DateFormat.Hm(),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              LineDisruptionPage.route,
              arguments: lineDisruption,
            );
          },
        );
}

class LineListTile extends ListTile {
  LineListTile({
    Key key,
    @required BuildContext context,
    @required tflApiClient.Line line,
  }) : super(
          key: key,
          title: NullableText(
            line.id,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: NullableText(
            line.name,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              LinePage.route,
              arguments: line.id,
            );
          },
        );
}

class LineRouteListTile extends ListTile {
  LineRouteListTile({
    Key key,
    @required BuildContext context,
    @required tflApiClient.LineRoute lineRoute,
  }) : super(
          key: key,
          title: NullableText(
            lineRoute.name,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: NullableText(
            lineRoute.serviceType,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              LineRoutePage.route,
              arguments: lineRoute,
            );
          },
        );
}

class LineStatusListTile extends ListTile {
  LineStatusListTile({
    Key key,
    @required BuildContext context,
    @required tflApiClient.LineStatus lineStatus,
  }) : super(
          key: key,
          title: NullableText(
            lineStatus.statusSeverityDescription,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: NullableText(
            lineStatus.disruption?.categoryDescription,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              LineStatusPage.route,
              arguments: lineStatus,
            );
          },
        );
}

class PredictionListTile extends ListTile {
  PredictionListTile({
    Key key,
    @required BuildContext context,
    @required tflApiClient.Prediction prediction,
  }) : super(
          key: key,
          title: NullableText(
            prediction.id,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: NullableText(
            '${DateFormat.Hm().format(prediction.expectedArrival)} - ${prediction.destinationName}',
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              PredictionPage.route,
              arguments: prediction,
            );
          },
        );
}

class StopPointListTile extends ListTile {
  StopPointListTile({
    Key key,
    @required BuildContext context,
    @required tflApiClient.StopPoint stopPoint,
  }) : super(
          key: key,
          title: NullableText(
            stopPoint.id,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: NullableText(
            stopPoint.commonName,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            /*Navigator.of(context).pushNamed(
              StopPointPage.route,
              arguments: stopPoint.id,
            );*/
          },
        );
}
