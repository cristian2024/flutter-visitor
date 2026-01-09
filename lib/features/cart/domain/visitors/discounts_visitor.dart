import 'package:flutter_visitor/core.dart';


/// ------------------------------------------------------------
/// DiscountsVisitor
/// ------------------------------------------------------------
///
/// Visitor encargado de calcular el descuento aplicado
/// a un producto según su tipo.
/// ------------------------------------------------------------
/// Regla de negocio:
/// ------------------------------------------------------------
/// - Productos físicos:
///   Aplica un descuento del 10% sobre el valor del producto.
///
/// - Servicios:
///   Aplica un descuento del 5% sobre el valor del servicio.
///
/// - Productos importados:
///   No aplica descuento.
/// ------------------------------------------------------------
/// Patrón de diseño:
/// ------------------------------------------------------------
/// - Implementa el patrón Visitor mediante `ProductVisitor<double>`.
/// - Permite encapsular la lógica de descuentos sin modificar
///   las clases concretas de `Product`.
/// ------------------------------------------------------------

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