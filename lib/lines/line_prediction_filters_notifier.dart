import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/filters_notifier.dart';

class LinePredictionFiltersNotifier extends FiltersNotifier<Prediction> {
  String? _destinationName;
  String? _stationName;

  String? get stationName {
    return _stationName;
  }

  set stationName(String? value) {
    _stationName = value;

    notifyListeners();
  }

  String? get destinationName {
    return _destinationName;
  }

  set destinationName(String? value) {
    _destinationName = value;

    notifyListeners();
  }

  @override
  void reset() {
    _destinationName = null;
    _stationName = null;

    notifyListeners();
  }
}
