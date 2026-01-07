import 'package:flutter_visitor/core.dart';

class DiscountsVisitor implements ProductVisitor<double> {
  static const double physicalDiscount = 0.10;
  static const double serviceDiscount = 0.05;

  @override
  double visitPhysicalProduct(PhysicalProduct product) {
    return product.value * physicalDiscount;
  }

  @override
  double visitServiceProduct(ServiceProduct product) {
    return product.value * serviceDiscount;
  }

  @override
  double visitImportedProduct(ImportedProduct product) {
    return 0;
  }
}