import 'package:tfl_api_client/tfl_api_client.dart';

import 'specification.dart';

class LineModeNameSpecification extends Specification<Line> {
  final String _modeName;

  LineModeNameSpecification(this._modeName) : assert(_modeName != null);

  @override
  bool isSatisfiedBy(Line value) {
    return value.modeName == _modeName;
  }

  @override
  String toString() {
    return _modeName;
  }
}
