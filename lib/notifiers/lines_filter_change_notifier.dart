import 'filter_change_notifier.dart';

class LinesFilterChangeNotifier extends FilterChangeNotifier {
  String _mode;

  String get mode => _mode;

  set mode(String value) {
    _mode = value;

    notifyListeners();
  }

  @override
  void reset() {
    _mode = null;

    notifyListeners();
  }
}
