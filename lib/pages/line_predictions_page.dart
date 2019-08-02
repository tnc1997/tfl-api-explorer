import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../material/expansion_tile.dart';
import '../notifiers/line_predictions_filter_change_notifier.dart';
import '../notifiers/tfl_api_change_notifier.dart';
import '../widgets/async.dart';
import 'line_predictions_filter_page.dart';

class LinePredictionsPage extends StatefulWidget {
  static const route = '/lines/:id/predictions';

  final String id;

  LinePredictionsPage({Key key, @required this.id}) : super(key: key);

  @override
  _LinePredictionsPageState createState() => _LinePredictionsPageState();
}

class _LinePredictionsPageState extends State<LinePredictionsPage> {
  StreamController<List<Prediction>> _streamController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predictions'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return LinePredictionsFilterPage(id: widget.id);
                  },
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<TflApiChangeNotifier>(
        builder: (context, tflApi, child) {
          return Consumer<LinePredictionsFilterChangeNotifier>(
            builder: (context, linePredictionsFilter, child) {
              final getPredictions = () {
                return tflApi.tflApi.lines.getPredictions(
                  widget.id,
                  stopPointId: linePredictionsFilter.stopPoint?.id,
                  destinationStationId: linePredictionsFilter.destination?.id,
                );
              };

              getPredictions()
                  .then(_streamController.add)
                  .catchError(_streamController.addError);

              return CircularProgressIndicatorStreamBuilder<List<Prediction>>(
                stream: _streamController.stream,
                builder: (context, data) {
                  return RefreshIndicator(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return PredictionExpansionTile(
                          context: context,
                          prediction: data[index],
                        );
                      },
                      itemCount: data.length,
                    ),
                    onRefresh: () {
                      return getPredictions()
                          .then(_streamController.add)
                          .catchError(_streamController.addError);
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _streamController.close();
  }

  @override
  void initState() {
    super.initState();

    _streamController = StreamController<List<Prediction>>();
  }
}
