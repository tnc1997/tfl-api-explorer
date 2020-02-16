import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/specifications/specification.dart';
import 'package:tfl_api_explorer/src/specifications/stop_point_modes_specification.dart';

class StopPointFiltersChangeNotifier extends FiltersChangeNotifier<StopPoint> {
  StopPointFiltersChangeNotifier() : _modes = new Set();

  final Set<String> _modes;

  Set<String> get modes => _modes;

  @override
  bool areSatisfiedBy(StopPoint value) {
    final specifications = <Specification<StopPoint>>[];

    if (_modes.isNotEmpty) {
      specifications.add(
        StopPointModesSpecification(
          modes: _modes,
        ),
      );
    }

    if (specifications.isNotEmpty) {
      final specification = specifications.fold<Specification<StopPoint>>(
        specifications.first,
        (previousValue, element) => previousValue.and(element),
      );

      return specification.isSatisfiedBy(value);
    }

    return true;
  }

  @override
  void reset() {
    _modes.clear();

    notifyListeners();
  }

  void addMode(String mode) {
    _modes.add(mode);

    notifyListeners();
  }

  void removeMode(String mode) {
    _modes.remove(mode);

    notifyListeners();
  }
}
