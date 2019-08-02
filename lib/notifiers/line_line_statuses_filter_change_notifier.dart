import 'filter_change_notifier.dart';

class LineLineStatusesFilterChangeNotifier extends FilterChangeNotifier {
  DateTime _date;

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;

    notifyListeners();
  }

  @override
  void reset() {
    _date = null;

    notifyListeners();
  }
}
