import 'package:tfl_api_client/tfl_api_client.dart';

import 'specification.dart';

class PredictionDestinationNameSpecification extends Specification<Prediction> {
  final String _destinationName;

  PredictionDestinationNameSpecification(this._destinationName)
      : assert(_destinationName != null);

  @override
  bool isSatisfiedBy(Prediction value) {
    return value.destinationName == _destinationName;
  }

  @override
  String toString() {
    return _destinationName;
  }
}
