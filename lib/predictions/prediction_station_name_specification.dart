import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/specification.dart';

class PredictionStationNameSpecification extends Specification<Prediction> {
  PredictionStationNameSpecification({
    required this.stationName,
  });

  final String stationName;

  @override
  bool isSatisfiedBy(Prediction value) {
    return value.stationName == stationName;
  }

  @override
  String toString() {
    return stationName;
  }
}
