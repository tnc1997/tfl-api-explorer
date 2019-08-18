import 'package:tfl_api_client/tfl_api_client.dart';

import '../specifications/line_route_service_type_specification.dart';
import '../specifications/specification.dart';
import 'filters_change_notifier.dart';

class LineLineRoutesFiltersChangeNotifier
    extends FiltersChangeNotifier<LineRoute> {
  String _serviceType;

  String get serviceType => _serviceType;

  set serviceType(String value) {
    _serviceType = value;

    notifyListeners();
  }

  @override
  bool areSatisfiedBy(LineRoute value) {
    final specifications = <Specification<LineRoute>>[];

    if (_serviceType != null) {
      specifications.add(
        LineRouteServiceTypeSpecification(_serviceType),
      );
    }

    if (specifications.isNotEmpty) {
      final specification = specifications.fold<Specification<LineRoute>>(
        null,
            (previousValue, element) => previousValue?.and(element) ?? element,
      );

      return specification.isSatisfiedBy(value);
    }

    return true;
  }

  @override
  void reset() {
    _serviceType = null;

    notifyListeners();
  }
}
