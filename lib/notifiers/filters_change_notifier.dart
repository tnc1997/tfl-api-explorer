import 'package:flutter/foundation.dart';

abstract class FiltersChangeNotifier<T> extends ChangeNotifier {
  bool areSatisfiedBy(T value);

  void reset();
}
