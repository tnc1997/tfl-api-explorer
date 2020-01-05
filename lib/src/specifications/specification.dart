import 'package:tfl_api_explorer/src/specifications/and_composite_specification.dart';
import 'package:tfl_api_explorer/src/specifications/or_composite_specification.dart';

abstract class Specification<T> {
  Specification<T> and(Specification<T> specification) {
    return AndCompositeSpecification(
      left: this,
      right: specification,
    );
  }

  bool isSatisfiedBy(T value);

  Specification<T> or(Specification<T> specification) {
    return OrCompositeSpecification(
      left: this,
      right: specification,
    );
  }
}
