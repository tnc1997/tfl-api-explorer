import 'package:tfl_api_client/tfl_api_client.dart';

import '../specifications/line_mode_name_specification.dart';
import '../specifications/specification.dart';
import 'filters_change_notifier.dart';

class LineFiltersChangeNotifier extends FiltersChangeNotifier<Line> {
  String? _modeName;

  String? get modeName => _modeName;

  set modeName(String? value) {
    _modeName = value;

    notifyListeners();
  }

  @override
  bool areSatisfiedBy(Line value) {
    final specifications = <Specification<Line>>[];

    if (_modeName != null) {
      specifications.add(
        LineModeNameSpecification(
          modeName: _modeName!,
        ),
      );
    }

    if (specifications.isNotEmpty) {
      final specification = specifications.fold<Specification<Line>>(
        specifications.first,
        (previousValue, element) => previousValue.and(element),
      );

      return specification.isSatisfiedBy(value);
    }

    return true;
  }

  @override
  void reset() {
    _modeName = null;

    notifyListeners();
  }
}
