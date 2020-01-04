import 'package:flutter/foundation.dart';
import 'package:tfl_api_explorer/src/specifications/composite_specification.dart';
import 'package:tfl_api_explorer/src/specifications/specification.dart';

class OrCompositeSpecification<T> extends CompositeSpecification<T> {
  OrCompositeSpecification({
    @required Specification<T> left,
    @required Specification<T> right,
  }) : super(
          left: left,
          right: right,
        );

  @override
  bool isSatisfiedBy(T value) {
    return left.isSatisfiedBy(value) || right.isSatisfiedBy(value);
  }
}
