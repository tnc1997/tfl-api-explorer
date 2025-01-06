import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../pages/predictions/prediction_page.dart';

class PredictionListTile extends StatelessWidget {
  const PredictionListTile({
    super.key,
    required this.prediction,
  });

  final Prediction prediction;

  @override
  Widget build(BuildContext context) {
    final expectedArrival = prediction.expectedArrival;
    final destinationName = prediction.destinationName;

    return ListTile(
      title: Text(
        prediction.id ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: expectedArrival != null && destinationName != null
          ? Text(
              '${DateFormat.Hm().format(expectedArrival)} - $destinationName',
              overflow: TextOverflow.ellipsis,
            )
          : null,
      onTap: () {
        Navigator.of(context).pushNamed(
          PredictionPage.routeName,
          arguments: prediction,
        );
      },
    );
  }
}
