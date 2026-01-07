import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/cart.dart';

class FinalPriceVisitor implements ProductVisitor<double> {
  final DiscountsVisitor _discountsVisitor = DiscountsVisitor();
  final TaxesVisitor _taxesVisitor = TaxesVisitor();

  @override
  double visitImportedProduct(ImportedProduct product) {
    return product.value +
        _taxesVisitor.visitImportedProduct(product) -
        _discountsVisitor.visitImportedProduct(product);
  }

  @override
  double visitPhysicalProduct(PhysicalProduct product) {
    return product.value +
        _taxesVisitor.visitPhysicalProduct(product) -
        _discountsVisitor.visitPhysicalProduct(product);
  }

  @override
  double visitServiceProduct(ServiceProduct product) {
    return product.value +
        _taxesVisitor.visitServiceProduct(product) -
        _discountsVisitor.visitServiceProduct(product);
  }
}
