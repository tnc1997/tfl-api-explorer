import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tfl_api_client/tfl_api_client.dart';

class AuthenticationNotifier extends ChangeNotifier {
  String? _appKey;

  http.Client? _client;

  String? get appKey => _appKey;

  http.Client? get client => _client;

  void signIn(String appKey) {
    _appKey = appKey;

    _client?.close();

    _client = clientViaAppKey(appKey);

    notifyListeners();
  }

  void signOut() {
    _appKey = null;

    _client?.close();

    _client = null;

    notifyListeners();
  }
}
