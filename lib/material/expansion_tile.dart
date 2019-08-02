import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../widgets/text.dart';

class LineDisruptionExpansionTile extends ExpansionTile {
  LineDisruptionExpansionTile({
    Key key,
    @required BuildContext context,
    @required LineDisruption lineDisruption,
  }) : super(
          key: key,
          title: NullableText(
            lineDisruption.category,
            overflow: TextOverflow.ellipsis,
          ),
          children: <Widget>[
            ListTile(
              title: Text('Description'),
              subtitle: NullableText(
                lineDisruption.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              isThreeLine: true,
            ),
            ListTile(
              title: Text('Summary'),
              subtitle: NullableText(
                lineDisruption.summary,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              isThreeLine: true,
            ),
            ListTile(
              title: Text('Information'),
              subtitle: NullableText(
                lineDisruption.additionalInfo,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              isThreeLine: true,
            ),
          ],
        );
}

class LineRouteExpansionTile extends ExpansionTile {
  LineRouteExpansionTile({
    Key key,
    @required BuildContext context,
    @required LineRoute lineRoute,
  }) : super(
          key: key,
          title: NullableText(
            lineRoute.name,
            overflow: TextOverflow.ellipsis,
          ),
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
              subtitle: NullableText(
                lineRoute.validTo?.toIso8601String(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ListTile(
              title: Text('Valid from'),
              subtitle: NullableText(
                lineRoute.validFrom?.toIso8601String(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
}

class LineStatusExpansionTile extends ExpansionTile {
  LineStatusExpansionTile({
    Key key,
    @required BuildContext context,
    @required LineStatus lineStatus,
  }) : super(
          key: key,
          title: NullableText(
            lineStatus.statusSeverityDescription,
            overflow: TextOverflow.ellipsis,
          ),
          children: <Widget>[
            ListTile(
              title: Text('Reason'),
              subtitle: NullableText(
                lineStatus.reason,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              isThreeLine: true,
            ),
            ListTile(
              title: Text('Created'),
              subtitle: NullableText(
                lineStatus.created?.toIso8601String(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ListTile(
              title: Text('Modified'),
              subtitle: NullableText(
                lineStatus.modified?.toIso8601String(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
}

class PredictionExpansionTile extends ExpansionTile {
  PredictionExpansionTile({
    Key key,
    @required BuildContext context,
    @required Prediction prediction,
  }) : super(
          key: key,
          title: NullableText(
            prediction.id,
            overflow: TextOverflow.ellipsis,
          ),
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
              title: Text('Expected arrival'),
              subtitle: NullableText(
                prediction.expectedArrival?.toIso8601String(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
}
