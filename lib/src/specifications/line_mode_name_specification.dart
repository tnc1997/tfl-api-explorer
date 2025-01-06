import 'package:tfl_api_client/tfl_api_client.dart';

import 'specification.dart';

class LineModeNameSpecification extends Specification<Line> {
  LineModeNameSpecification({
    required this.modeName,
  });

  final String modeName;

  @override
  bool isSatisfiedBy(Line value) {
    return value.modeName == modeName;
  }

  @override
  String toString() {
    return modeName;
  }
}
