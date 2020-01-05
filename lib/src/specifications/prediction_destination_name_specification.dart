import 'package:flutter/foundation.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/specifications/specification.dart';

class PredictionDestinationNameSpecification extends Specification<Prediction> {
  PredictionDestinationNameSpecification({
    @required this.destinationName,
  });

  final String destinationName;

  @override
  bool isSatisfiedBy(Prediction value) {
    return value.destinationName == destinationName;
  }

  @override
  String toString() {
    return destinationName;
  }
}
