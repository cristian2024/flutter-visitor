import 'package:flutter_visitor/core.dart';

abstract interface class ProductVisitor<T> {

  T visitImportedProduct(ImportedProduct product);
  T visitServiceProduct(ServiceProduct product);
  T visitPhysicalProduct(PhysicalProduct product);
}