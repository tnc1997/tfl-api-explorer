import 'package:flutter/foundation.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/specifications/specification.dart';

class StopPointModesSpecification extends Specification<StopPoint> {
  StopPointModesSpecification({
    @required this.modes,
  });

  final Set<String> modes;

  @override
  bool isSatisfiedBy(StopPoint value) {
    return value.modes.toSet().containsAll(modes);
  }

  @override
  String toString() {
    return modes.toString();
  }
}
