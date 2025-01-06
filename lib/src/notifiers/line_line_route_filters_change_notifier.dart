import 'package:tfl_api_client/tfl_api_client.dart';

import '../specifications/line_route_service_type_specification.dart';
import '../specifications/specification.dart';
import 'filters_change_notifier.dart';

class LineLineRouteFiltersChangeNotifier
    extends FiltersChangeNotifier<MatchedRoute> {
  String? _serviceType;

  String? get serviceType => _serviceType;

  set serviceType(String? value) {
    _serviceType = value;

    notifyListeners();
  }

  @override
  bool areSatisfiedBy(MatchedRoute value) {
    final specifications = <Specification<MatchedRoute>>[];

    if (_serviceType != null) {
      specifications.add(
        LineRouteServiceTypeSpecification(
          serviceType: _serviceType!,
        ),
      );
    }

    if (specifications.isNotEmpty) {
      final specification = specifications.fold<Specification<MatchedRoute>>(
        specifications.first,
        (previousValue, element) => previousValue.and(element),
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
