import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/filters_notifier.dart';

class LineLineRouteFiltersNotifier extends FiltersNotifier<MatchedRoute> {
  String? _serviceType;

  String? get serviceType {
    return _serviceType;
  }

  set serviceType(String? value) {
    _serviceType = value;

    notifyListeners();
  }

  @override
  void reset() {
    _serviceType = null;

    notifyListeners();
  }
}
