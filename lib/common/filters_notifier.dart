import 'package:flutter/foundation.dart';

abstract class FiltersNotifier<T> extends ChangeNotifier {
  bool areSatisfiedBy(T value);

  void reset();
}
