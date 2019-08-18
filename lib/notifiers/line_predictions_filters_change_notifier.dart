import 'package:tfl_api_client/tfl_api_client.dart';

import '../specifications/prediction_destination_name_specification.dart';
import '../specifications/prediction_station_name_specification.dart';
import '../specifications/specification.dart';
import 'filters_change_notifier.dart';

class LinePredictionsFiltersChangeNotifier
    extends FiltersChangeNotifier<Prediction> {
  String _destinationName;

  String _stationName;

  String get stationName => _stationName;

  set stationName(String value) {
    _stationName = value;

    notifyListeners();
  }

  String get destinationName => _destinationName;

  set destinationName(String value) {
    _destinationName = value;

    notifyListeners();
  }

  @override
  bool areSatisfiedBy(Prediction value) {
    final specifications = <Specification<Prediction>>[];

    if (_destinationName != null) {
      specifications.add(
        PredictionDestinationNameSpecification(_destinationName),
      );
    }

    if (_stationName != null) {
      specifications.add(
        PredictionStationNameSpecification(_stationName),
      );
    }

    if (specifications.isNotEmpty) {
      final specification = specifications.fold<Specification<Prediction>>(
        null,
        (previousValue, element) => previousValue?.and(element) ?? element,
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
