import 'filters_change_notifier.dart';

class LineLineStatusesFiltersChangeNotifier extends FiltersChangeNotifier {
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
