import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class TflApiChangeNotifier extends ChangeNotifier {
  String _appId;

  String _appKey;

  Client _client;

  TflApi _tflApi;

  String get appId => _appId;

  String get appKey => _appKey;

  TflApi get tflApi => _tflApi;

  Future<void> update(String appId, String appKey) async {
    final prefs = await SharedPreferences.getInstance();

    _client?.close();

    _appId = appId;
    _appKey = appKey;

    prefs.setString('APP_ID', _appId);
    prefs.setString('APP_KEY', _appKey);

    _client = clientViaAppKeyAppId(_appKey, _appId);
    _tflApi = TflApi(_client);

    notifyListeners();
  }
}
