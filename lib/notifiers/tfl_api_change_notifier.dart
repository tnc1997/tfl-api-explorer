import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class TflApiChangeNotifier extends ChangeNotifier {
  String _appId;

  String _appKey;

  Client _client;

  TflApi _tflApi;

  TflApiChangeNotifier() {
    _client = clientViaAppKeyAppId('', '');
    _tflApi = TflApi(_client);
  }

  String get appId => _appId;

  String get appKey => _appKey;

  TflApi get tflApi => _tflApi;

  void update(String appId, String appKey) {
    _client.close();

    _appId = appId;
    _appKey = appKey;

    _client = clientViaAppKeyAppId(_appKey, _appId);
    _tflApi = TflApi(_client);

    notifyListeners();
  }
}
