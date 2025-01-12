import 'package:flutter/foundation.dart';

abstract class FiltersNotifier<T> extends ChangeNotifier {
  void reset();
}
