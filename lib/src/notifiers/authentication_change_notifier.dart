import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class AuthenticationChangeNotifier extends ChangeNotifier {
  String? _appKey;

  Client? _client;

  String? get appKey => _appKey;

  Client? get client => _client;

  void login(String appKey) {
    _appKey = appKey;

    _client?.close();

    _client = clientViaAppKey(appKey);

    notifyListeners();
  }

  void logout() {
    _appKey = null;

    _client?.close();

    _client = null;

    notifyListeners();
  }
}
