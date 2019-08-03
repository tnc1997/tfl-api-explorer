import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart' as tflApiClient;

import '../pages/line_disruptions/line_disruption_page.dart';
import '../pages/line_routes/line_route_page.dart';
import '../pages/line_statuses/line_status_page.dart';
import '../pages/lines/line_page.dart';
import '../pages/predictions/prediction_page.dart';
import '../pages/route_sequences/route_sequence_page.dart';
import '../pages/stop_points/stop_point_page.dart';
import '../pages/stop_point_sequences/stop_point_sequence_page.dart';
import '../widgets/text.dart';

class AlignedListTile extends ListTile {
  AlignedListTile({
    Key key,
    Widget leading = const SizedBox(),
    Widget title,
    Widget subtitle,
    Widget trailing,
    bool isThreeLine = false,
    bool dense,
    EdgeInsetsGeometry contentPadding,
    bool enabled = true,
    VoidCallback onTap,
    VoidCallback onLongPress,
    bool selected = false,
  }) : super(
          key: key,
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          isThreeLine: isThreeLine,
          dense: dense,
          contentPadding: contentPadding,
          enabled: enabled,
          onTap: onTap,
          onLongPress: onLongPress,
          selected: selected,
        );
}

class LineDisruptionListTile extends ListTile {
  LineDisruptionListTile({
    Key key,
    @required BuildContext context,
    @required tflApiClient.LineDisruption lineDisruption,
  }) : super(
          key: key,
          leading: SizedBox(),
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
          leading: SizedBox(),
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
              arguments: line,
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
          leading: SizedBox(),
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
          leading: SizedBox(),
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
          leading: SizedBox(),
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

class RouteSequenceListTile extends ListTile {
  RouteSequenceListTile({
    Key key,
    @required BuildContext context,
    @required tflApiClient.RouteSequence routeSequence,
  }) : super(
          key: key,
          leading: SizedBox(),
          title: NullableText(
            routeSequence.direction,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: NullableText(
            routeSequence.orderedLineRoutes.first.name,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              RouteSequencePage.route,
              arguments: routeSequence,
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
          leading: SizedBox(),
          title: NullableText(
            stopPoint.id,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: NullableText(
            stopPoint.commonName,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              StopPointPage.route,
              arguments: stopPoint,
            );
          },
        );
}

class StopPointSequenceListTile extends ListTile {
  StopPointSequenceListTile({
    Key key,
    @required BuildContext context,
    @required tflApiClient.StopPointSequence stopPointSequence,
  }) : super(
          key: key,
          leading: SizedBox(),
          title: NullableText(
            '${stopPointSequence.branchId}',
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: NullableText(
            stopPointSequence.serviceType,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              StopPointSequencePage.route,
              arguments: stopPointSequence,
            );
          },
        );
}
