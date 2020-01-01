import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/material/scroll_view.dart';

class LinePage extends StatefulWidget {
  static const route = '/lines/:id';

  final Line line;

  LinePage({
    Key key,
    @required this.line,
  }) : super(key: key);

  @override
  _LinePageState createState() => _LinePageState();
}

class _LinePageState extends State<LinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.line.id),
      ),
      body: LineListView(
        context: context,
        line: widget.line,
      ),
    );
  }
}
