import 'package:http/http.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class TflApiState {
  String _appId;

  String _appKey;

  Client _client;

  TflApi _tflApi;

  String get appId => _appId;

  set appId(String value) {
    _appId = value;

    _client?.close();

    _client = clientViaAppKeyAppId(_appKey ?? '', _appId ?? '');
    _tflApi = TflApi(_client);
  }

  String get appKey => _appKey;

  set appKey(String value) {
    _appKey = value;

    _client?.close();

    _client = clientViaAppKeyAppId(_appKey ?? '', _appId ?? '');
    _tflApi = TflApi(_client);
  }

  TflApi get tflApi => _tflApi;
}
