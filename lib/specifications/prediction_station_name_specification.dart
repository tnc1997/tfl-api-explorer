import 'package:tfl_api_client/tfl_api_client.dart';

import 'specification.dart';

class PredictionStationNameSpecification extends Specification<Prediction> {
  final String _stationName;

  PredictionStationNameSpecification(this._stationName)
      : assert(_stationName != null);

  @override
  bool isSatisfiedBy(Prediction value) {
    return value.stationName == _stationName;
  }

  @override
  String toString() {
    return _stationName;
  }
}
