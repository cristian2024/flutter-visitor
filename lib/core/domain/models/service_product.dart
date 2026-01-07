import 'package:flutter_visitor/core.dart';

class ServiceProduct extends Product {
  const ServiceProduct({
    required super.id,
    required super.name,
    required super.value,
    super.description,
    super.imageLink,
  });
  @override
  double accept(ProductVisitor visitor) {
    return visitor.visitServiceProduct(this);
  }
}
