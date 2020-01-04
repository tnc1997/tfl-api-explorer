import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/line_statuses/line_status_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LineStatusListTile extends StatelessWidget {
  LineStatusListTile({
    Key key,
    @required this.lineStatus,
  }) : super(
          key: key,
        );

  final LineStatus lineStatus;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
}
