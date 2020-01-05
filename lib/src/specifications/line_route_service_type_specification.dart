import 'package:flutter/foundation.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/specifications/specification.dart';

class LineRouteServiceTypeSpecification extends Specification<LineRoute> {
  LineRouteServiceTypeSpecification({
    @required this.serviceType,
  });

  final String serviceType;

  @override
  bool isSatisfiedBy(LineRoute value) {
    return value.serviceType == serviceType;
  }

  @override
  String toString() {
    return serviceType;
  }
}
