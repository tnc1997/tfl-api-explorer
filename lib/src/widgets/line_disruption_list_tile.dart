import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/line_disruptions/line_disruption_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LineDisruptionListTile extends StatelessWidget {
  LineDisruptionListTile({
    Key key,
    @required this.lineDisruption,
  }) : super(
          key: key,
        );

  final LineDisruption lineDisruption;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NullableText(
        lineDisruption.categoryDescription,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        DateFormat.Hm().format(
          lineDisruption.lastUpdate ?? lineDisruption.created,
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          LineDisruptionPage.route,
          arguments: lineDisruption,
        );
      },
    );
  }
}
