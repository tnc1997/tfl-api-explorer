import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/filters_notifier.dart';
import '../common/specification.dart';
import '../predictions/prediction_destination_name_specification.dart';
import '../predictions/prediction_station_name_specification.dart';

class LinePredictionFiltersNotifier extends FiltersNotifier<Prediction> {
  String? _destinationName;

  String? _stationName;

  String? get stationName => _stationName;

  set stationName(String? value) {
    _stationName = value;

    notifyListeners();
  }

  String? get destinationName => _destinationName;

  set destinationName(String? value) {
    _destinationName = value;

    notifyListeners();
  }

  @override
  bool areSatisfiedBy(Prediction value) {
    final specifications = <Specification<Prediction>>[];

    if (_destinationName != null) {
      specifications.add(
        PredictionDestinationNameSpecification(
          destinationName: _destinationName!,
        ),
      );
    }

    if (_stationName != null) {
      specifications.add(
        PredictionStationNameSpecification(
          stationName: _stationName!,
        ),
      );
    }

    if (specifications.isNotEmpty) {
      final specification = specifications.fold<Specification<Prediction>>(
        specifications.first,
        (previousValue, element) => previousValue.and(element),
      );

      return specification.isSatisfiedBy(value);
    }

    return true;
  }

  @override
  void reset() {
    _destinationName = null;
    _stationName = null;

    notifyListeners();
  }
}
