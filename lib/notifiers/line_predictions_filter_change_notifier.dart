import 'filter_change_notifier.dart';

class LinePredictionsFilterChangeNotifier extends FilterChangeNotifier {
  String _stopPoint;

  String _destination;

  String get stopPoint => _stopPoint;

  set stopPoint(String value) {
    _stopPoint = value;

    notifyListeners();
  }

  String get destination => _destination;

  set destination(String value) {
    _destination = value;

    notifyListeners();
  }

  @override
  void reset() {
    _stopPoint = null;

    notifyListeners();
  }
}
