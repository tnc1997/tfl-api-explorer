import 'package:flutter/foundation.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/specifications/specification.dart';

class PlaceCommonNameSpecification extends Specification<Place> {
  PlaceCommonNameSpecification({
    @required this.commonName,
  });

  final String commonName;

  @override
  bool isSatisfiedBy(Place value) {
    return value.commonName.toLowerCase().contains(commonName.toLowerCase());
  }

  @override
  String toString() {
    return commonName;
  }
}
