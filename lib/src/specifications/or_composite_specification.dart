import 'composite_specification.dart';

class OrCompositeSpecification<T> extends CompositeSpecification<T> {
  OrCompositeSpecification({
    required super.left,
    required super.right,
  });

  @override
  bool isSatisfiedBy(T value) {
    return left.isSatisfiedBy(value) || right.isSatisfiedBy(value);
  }
}
