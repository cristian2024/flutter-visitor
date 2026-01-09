import 'package:flutter_visitor/core.dart';


/// ------------------------------------------------------------
/// ServiceProduct
/// ------------------------------------------------------------
///
/// Implementación concreta de `Product` que representa
/// un servicio.
/// ------------------------------------------------------------
/// Características:
/// ------------------------------------------------------------
/// - Su comportamiento específico se delega al Visitor.
/// ------------------------------------------------------------
/// Patrón de diseño:
/// ------------------------------------------------------------
/// - Implementa el patrón Visitor sobrescribiendo
///   el método `accept`.
/// - Redirige la operación al método
///   `visitServiceProduct` del visitor.
/// ------------------------------------------------------------

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
