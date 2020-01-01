import 'package:tfl_api_explorer/src/specifications/composite_specification.dart';
import 'package:tfl_api_explorer/src/specifications/specification.dart';

class AndCompositeSpecification<T> extends CompositeSpecification<T> {
  AndCompositeSpecification(Specification<T> left, Specification<T> right)
      : super(left, right);

  @override
  bool isSatisfiedBy(T value) {
    return left.isSatisfiedBy(value) && right.isSatisfiedBy(value);
  }
}
