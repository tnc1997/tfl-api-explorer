import 'package:tfl_api_client/tfl_api_client.dart';

import 'specification.dart';

class RoadDisplayNameSpecification extends Specification<RoadCorridor> {
  RoadDisplayNameSpecification({
    required this.displayName,
  });

  final String displayName;

  @override
  bool isSatisfiedBy(RoadCorridor value) {
    return value.displayName
            ?.toLowerCase()
            .contains(displayName.toLowerCase()) ??
        false;
  }

  @override
  String toString() {
    return displayName;
  }
}
