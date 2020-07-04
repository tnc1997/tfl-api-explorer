import 'package:flutter/foundation.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/specifications/specification.dart';

class RoadDisplayNameSpecification extends Specification<Road> {
  RoadDisplayNameSpecification({
    @required this.displayName,
  });

  final String displayName;

  @override
  bool isSatisfiedBy(Road value) {
    return value.displayName.toLowerCase().contains(displayName.toLowerCase());
  }

  @override
  String toString() {
    return displayName;
  }
}
