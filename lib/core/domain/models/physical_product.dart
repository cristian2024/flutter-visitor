import 'package:flutter_visitor/core.dart';


/// ------------------------------------------------------------
/// PhysicalProduct
/// ------------------------------------------------------------
///
/// Implementación concreta de `Product` que representa
/// un producto físico.
/// ------------------------------------------------------------
/// Características:
/// ------------------------------------------------------------
/// - Corresponde a bienes tangibles.
/// - Puede estar sujeto a descuentos e impuestos estándar.
/// - Su comportamiento específico se delega al Visitor.
/// ------------------------------------------------------------
/// Patrón de diseño:
/// ------------------------------------------------------------
/// - Implementa el patrón Visitor sobrescribiendo
///   el método `accept`.
/// - Redirige la operación al método
///   `visitPhysicalProduct` del visitor.
/// ------------------------------------------------------------
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
