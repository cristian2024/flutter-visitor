import 'package:flutter_visitor/core/domain/models/imported_product.dart';
import 'package:flutter_visitor/core/domain/models/physical_product.dart';
import 'package:flutter_visitor/core/domain/models/service_product.dart';
import 'package:flutter_visitor/core/domain/visitors/product_visitor.dart';

/// ------------------------------------------------------------
/// TaxesVisitor
/// ------------------------------------------------------------
///
/// Visitor encargado de calcular los impuestos aplicables
/// a un producto según su tipo.
/// ------------------------------------------------------------
/// Reglas de negocio:
/// ------------------------------------------------------------
/// - Productos físicos:
///   Aplica IVA del 19% sobre el valor del producto.
///
/// - Servicios:
///   Aplica IVA del 19% sobre el valor del servicio.
///
/// - Productos importados:
///   Aplica IVA del 19% más un arancel de importación del 5%.
/// ------------------------------------------------------------
/// Constantes:
/// ------------------------------------------------------------
/// * [vat]
///   Porcentaje de IVA aplicado a productos físicos y servicios.
///
/// * [importDuty]
///   Porcentaje adicional aplicado a productos importados.
/// ------------------------------------------------------------
/// Patrón de diseño:
/// ------------------------------------------------------------
/// - Implementa el patrón Visitor mediante `ProductVisitor<double>`.
/// - Permite encapsular la lógica de impuestos sin modificar
///   las clases concretas de `Product`.
/// ------------------------------------------------------------

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
