import 'package:tfl_api_client/tfl_api_client.dart';

import '../specifications/line_route_service_type_specification.dart';
import '../specifications/specification.dart';
import 'filters_change_notifier.dart';

class LineLineRoutesFiltersChangeNotifier
    extends FiltersChangeNotifier<LineRoute> {
  LineLineRoutesFiltersChangeNotifier()
      : super(
          <String, Specification<LineRoute>>{
            'Service type': LineRouteServiceTypeSpecification('Regular'),
          },
        );

  String get serviceType {
    return specifications['Service type']?.toString();
  }

  set serviceType(String value) {
    super.update(
      'Service type',
      LineRouteServiceTypeSpecification(value),
    );
  }
}
