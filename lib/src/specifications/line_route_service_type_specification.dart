import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/specifications/specification.dart';

class LineRouteServiceTypeSpecification extends Specification<LineRoute> {
  final String _serviceType;

  LineRouteServiceTypeSpecification(this._serviceType)
      : assert(_serviceType != null);

  @override
  bool isSatisfiedBy(LineRoute value) {
    return value.serviceType == _serviceType;
  }

  @override
  String toString() {
    return _serviceType;
  }
}
