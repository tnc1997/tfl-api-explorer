import 'specification.dart';

abstract class CompositeSpecification<T> extends Specification<T> {
  final Specification<T> left;

  final Specification<T> right;

  CompositeSpecification(this.left, this.right)
      : assert(left != null),
        assert(right != null);
}
