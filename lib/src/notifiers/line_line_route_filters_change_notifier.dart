import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/specifications/line_route_service_type_specification.dart';
import 'package:tfl_api_explorer/src/specifications/specification.dart';

class LineLineRouteFiltersChangeNotifier
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
