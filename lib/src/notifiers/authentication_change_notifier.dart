import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class AuthenticationChangeNotifier extends ChangeNotifier {
  String _appId;

  String _appKey;

  Client _client;

  String get appId => _appId;

  String get appKey => _appKey;

  Client get client => _client;

  void login(String appId, String appKey) {
    if (appId == null) throw ArgumentError.notNull('appId');
    if (appKey == null) throw ArgumentError.notNull('appKey');

    _appId = appId;
    _appKey = appKey;

    _client?.close();

    _client = clientViaAppKeyAppId(_appKey, _appId);

    notifyListeners();
  }

  void logout() {
    _appId = null;
    _appKey = null;

    _client?.close();

    _client = null;

    notifyListeners();
  }
}
