import 'package:tfl_api_client/tfl_api_client.dart';

import 'filter_change_notifier.dart';

class LinesFilterChangeNotifier extends FilterChangeNotifier {
  Mode _mode;

  Mode get mode => _mode;

  set mode(Mode value) {
    _mode = value;

    notifyListeners();
  }

  @override
  void reset() {
    _mode = null;

    notifyListeners();
  }
}
