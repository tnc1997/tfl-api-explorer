import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/specifications/specification.dart';

class LineRouteServiceTypeSpecification extends Specification<MatchedRoute> {
  LineRouteServiceTypeSpecification({
    required this.serviceType,
  });

  final String serviceType;

  @override
  bool isSatisfiedBy(MatchedRoute value) {
    return value.serviceType == serviceType;
  }

  @override
  String toString() {
    return serviceType;
  }
}
