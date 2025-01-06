import 'package:tfl_api_client/tfl_api_client.dart';

import 'specification.dart';

class StopPointModesSpecification extends Specification<StopPoint> {
  StopPointModesSpecification({
    required this.modes,
  });

  final Set<String> modes;

  @override
  bool isSatisfiedBy(StopPoint value) {
    return value.modes?.toSet().containsAll(modes) ?? false;
  }

  @override
  String toString() {
    return modes.toString();
  }
}
