import 'package:flutter_visitor/core/domain/models/imported_product.dart';
import 'package:flutter_visitor/core/domain/models/physical_product.dart';
import 'package:flutter_visitor/core/domain/models/service_product.dart';
import 'package:flutter_visitor/core/domain/visitors/product_visitor.dart';

class TaxesVisitor implements ProductVisitor<double> {
  static const double vat = 0.19;
  static const double importDuty = 0.05;

  @override
  double visitPhysicalProduct(PhysicalProduct product) {
    return product.value * vat;
  }

  @override
  double visitServiceProduct(ServiceProduct product) {
    return product.value * vat;
  }

  @override
  double visitImportedProduct(ImportedProduct product) {
    return product.value * (vat + importDuty);
  }
}
