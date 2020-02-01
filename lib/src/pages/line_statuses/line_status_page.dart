import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LineStatusPage extends StatelessWidget {
  static const route = '/line_statuses/:id';

  LineStatusPage({
    Key key,
    @required this.lineStatus,
  }) : super(
          key: key,
        );

  final LineStatus lineStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lineStatus.statusSeverityDescription),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NullableText(
          lineStatus.reason,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
