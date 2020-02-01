import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LineDisruptionPage extends StatelessWidget {
  static const routeName = '/line_disruptions/:id';

  LineDisruptionPage({
    Key key,
    @required this.lineDisruption,
  }) : super(
          key: key,
        );

  final LineDisruption lineDisruption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lineDisruption.categoryDescription),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NullableText(
          lineDisruption.description,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
