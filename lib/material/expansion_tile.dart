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
