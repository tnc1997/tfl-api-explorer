import 'package:flutter/foundation.dart';

class LinesFilterChangeNotifier extends ChangeNotifier {
  String _mode;

  String get mode => _mode;

  set mode(String value) {
    _mode = value;

    notifyListeners();
  }
}
