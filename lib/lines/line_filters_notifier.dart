import 'package:tfl_api_client/tfl_api_client.dart';

import '../common/filters_notifier.dart';

class LineFiltersNotifier extends FiltersNotifier<Line> {
  final _modes = <String>[];

  List<String> get modes {
    return _modes.toList();
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
