import 'package:tfl_api_client/tfl_api_client.dart';

import 'specification.dart';

class PlaceCommonNameSpecification extends Specification<Place> {
  final String _commonName;

  PlaceCommonNameSpecification(this._commonName) : assert(_commonName != null);

  @override
  bool isSatisfiedBy(Place value) {
    return value.commonName.toLowerCase().contains(_commonName.toLowerCase());
  }

  @override
  String toString() {
    return _commonName;
  }
}
