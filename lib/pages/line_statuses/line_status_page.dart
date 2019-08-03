import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../widgets/text.dart';

class LineStatusPage extends StatefulWidget {
  static const route = '/line_statuses/:id';

  final LineStatus lineStatus;

  LineStatusPage({
    Key key,
    @required this.lineStatus,
  }) : super(key: key);

  @override
  _LineStatusPageState createState() => _LineStatusPageState();
}

class _LineStatusPageState extends State<LineStatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lineStatus.statusSeverityDescription),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NullableText(widget.lineStatus.reason),
      ),
    );
  }
}
