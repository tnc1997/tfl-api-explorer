import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/scroll_view.dart';

class PredictionPage extends StatefulWidget {
  static const route = '/predictions/:id';

  final Prediction prediction;

  PredictionPage({
    Key key,
    @required this.prediction,
  }) : super(key: key);

  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.prediction.id),
      ),
      body: PredictionListView(
        context: context,
        prediction: widget.prediction,
      ),
    );
  }
}
