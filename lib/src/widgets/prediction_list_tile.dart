import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/pages/predictions/prediction_page.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class PredictionListTile extends StatelessWidget {
  PredictionListTile({
    Key key,
    @required this.prediction,
  }) : super(
          key: key,
        );

  final Prediction prediction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NullableText(
        prediction.id,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${DateFormat.Hm().format(prediction.expectedArrival)} - ${prediction.destinationName}',
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          PredictionPage.routeName,
          arguments: prediction,
        );
      },
    );
  }
}
