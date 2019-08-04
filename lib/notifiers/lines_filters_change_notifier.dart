import 'package:tfl_api_client/tfl_api_client.dart';

import '../specifications/line_mode_name_specification.dart';
import '../specifications/specification.dart';
import 'filters_change_notifier.dart';

class LinesFiltersChangeNotifier extends FiltersChangeNotifier<Line> {
  LinesFiltersChangeNotifier()
      : super(
          <String, Specification<Line>>{
            'Mode name': LineModeNameSpecification('tube'),
          },
        );

  String get modeName {
    return specifications['Mode name']?.toString();
  }

  set modeName(String value) {
    super.update(
      'Mode name',
      LineModeNameSpecification(value),
    );
  }
}
