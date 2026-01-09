import 'package:flutter_visitor/core.dart';

/// ------------------------------------------------------------
/// ProductVisitor
/// ------------------------------------------------------------
///
/// Interfaz que define el contrato del patrón Visitor
/// para operar sobre distintos tipos de `Product`.
/// ------------------------------------------------------------
/// Propósito:
/// ------------------------------------------------------------
/// - Permitir agregar nuevas operaciones sobre productos
///   sin modificar sus clases concretas.
/// - Encapsular comportamientos que varían según el tipo
///   de producto.
/// ------------------------------------------------------------
/// Genérico:
/// ------------------------------------------------------------
/// * [T]
///   Tipo de retorno de la operación realizada por el visitor.
/// ------------------------------------------------------------
/// Métodos:
/// ------------------------------------------------------------
/// * visitImportedProduct
///   Ejecuta la operación para productos importados.
///
/// * visitServiceProduct
///   Ejecuta la operación para servicios.
///
/// * visitPhysicalProduct
///   Ejecuta la operación para productos físicos.
/// ------------------------------------------------------------
abstract interface class ProductVisitor<T> {

  T visitImportedProduct(ImportedProduct product);
  T visitServiceProduct(ServiceProduct product);
  T visitPhysicalProduct(PhysicalProduct product);
}