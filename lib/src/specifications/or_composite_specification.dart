import 'package:tfl_api_explorer/src/specifications/composite_specification.dart';
import 'package:tfl_api_explorer/src/specifications/specification.dart';

class OrCompositeSpecification<T> extends CompositeSpecification<T> {
  OrCompositeSpecification(Specification<T> left, Specification<T> right)
      : super(left, right);

  @override
  bool isSatisfiedBy(T value) {
    return left.isSatisfiedBy(value) || right.isSatisfiedBy(value);
  }
}
