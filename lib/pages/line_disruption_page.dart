import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../widgets/text.dart';

class LineDisruptionPage extends StatefulWidget {
  static const route = '/line_disruptions/:id';

  final LineDisruption lineDisruption;

  LineDisruptionPage({Key key, @required this.lineDisruption})
      : super(key: key);

  @override
  _LineDisruptionPageState createState() => _LineDisruptionPageState();
}

class _LineDisruptionPageState extends State<LineDisruptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lineDisruption.categoryDescription),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NullableText(widget.lineDisruption.description),
      ),
    );
  }
}
