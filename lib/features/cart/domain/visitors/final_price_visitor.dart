import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/cart.dart';

/// ------------------------------------------------------------
/// FinalPriceVisitor
/// ------------------------------------------------------------
///
/// Visitor encargado de calcular el precio final de un producto,
/// teniendo en cuenta impuestos y descuentos.
/// ------------------------------------------------------------
/// Cálculo:
/// ------------------------------------------------------------
/// El precio final se obtiene mediante la fórmula:
///
///   valor base + impuestos - descuentos
///
/// Cada componente es calculado usando sus respectivos visitors.
/// ------------------------------------------------------------
/// Integración:
/// ------------------------------------------------------------
/// - Utiliza `DiscountsVisitor` para calcular los descuentos.
/// - Utiliza `TaxesVisitor` para calcular los impuestos.
/// ------------------------------------------------------------
/// Patrón de diseño:
/// ------------------------------------------------------------
/// - Implementa el patrón Visitor mediante `ProductVisitor<double>`.
/// - Centraliza la lógica de cálculo del precio final sin
///   modificar las clases concretas de `Product`.
/// ------------------------------------------------------------

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
