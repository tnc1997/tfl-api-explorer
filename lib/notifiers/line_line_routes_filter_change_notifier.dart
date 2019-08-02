import 'filter_change_notifier.dart';

class LineLineRoutesFilterChangeNotifier extends FilterChangeNotifier {
  final _serviceTypes = Set<String>();

  List<String> get serviceTypes => List.unmodifiable(_serviceTypes);

  bool addServiceType(String serviceType) {
    final result = _serviceTypes.add(serviceType);

    notifyListeners();

    return result;
  }

  void clearServiceTypes() {
    _serviceTypes.clear();

    notifyListeners();
  }

  bool removeServiceType(String serviceType) {
    final result = _serviceTypes.remove(serviceType);

    notifyListeners();

    return result;
  }

  @override
  void reset() {
    _serviceTypes.clear();

    notifyListeners();
  }
}
