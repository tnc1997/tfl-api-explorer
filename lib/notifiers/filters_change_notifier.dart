import 'package:flutter/foundation.dart';

import '../specifications/specification.dart';

abstract class FiltersChangeNotifier<T> extends ChangeNotifier {
  final Map<String, Specification<T>> _specifications;

  FiltersChangeNotifier(this._specifications);

  Specification<T> get specification {
    return _specifications.values.where((value) {
      return value != null;
    }).fold(null, (previousValue, element) {
      return previousValue?.and(element) ?? element;
    });
  }

  Map<String, Specification<T>> get specifications {
    return Map.unmodifiable(_specifications);
  }

  Specification<T> update(
    String key,
    Specification<T> specification,
  ) {
    final result = _specifications.update(
      key,
      (value) => specification,
      ifAbsent: () => specification,
    );

    notifyListeners();

    return result;
  }

  Specification<T> remove(String key) {
    final result = _specifications.remove(key);

    notifyListeners();

    return result;
  }

  void reset() {
    _specifications.updateAll((key, value) => null);

    notifyListeners();
  }
}
