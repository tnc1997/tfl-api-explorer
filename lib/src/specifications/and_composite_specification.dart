import 'package:tfl_api_explorer/src/specifications/composite_specification.dart';

class AndCompositeSpecification<T> extends CompositeSpecification<T> {
  AndCompositeSpecification({
    required super.left,
    required super.right,
  });

  @override
  bool isSatisfiedBy(T value) {
    return left.isSatisfiedBy(value) && right.isSatisfiedBy(value);
  }
}
