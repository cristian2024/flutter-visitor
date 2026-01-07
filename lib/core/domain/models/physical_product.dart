import 'package:flutter_visitor/core.dart';

class PhysicalProduct extends Product {
  const PhysicalProduct({
    required super.id,
    required super.name,
    required super.value,
    super.description,
    super.imageLink,
  });

  @override
  double accept(ProductVisitor visitor) {
    return visitor.visitPhysicalProduct(this);
  }
}
