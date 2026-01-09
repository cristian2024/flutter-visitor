import 'package:flutter_visitor/core/domain/visitors/product_visitor.dart';

import 'product.dart';

/// ------------------------------------------------------------
/// ImportedProduct
/// ------------------------------------------------------------
///
/// Implementación concreta de `Product` que representa
/// un producto importado.
/// ------------------------------------------------------------
/// Características:
/// ------------------------------------------------------------
/// - Está sujeto a impuestos adicionales por importación.
/// - Su comportamiento específico se delega al Visitor.
/// ------------------------------------------------------------
/// Patrón de diseño:
/// ------------------------------------------------------------
/// - Implementa el patrón Visitor sobrescribiendo
///   el método `accept`.
/// - Redirige la operación al método
///   `visitImportedProduct` del visitor.
/// ------------------------------------------------------------
class ImportedProduct extends Product {
  const ImportedProduct({
    required super.id,
    required super.name,
    required super.value,
    super.description,
    super.imageLink,
  });

  @override
  double accept(ProductVisitor visitor) {
    return visitor.visitImportedProduct(this);
  }
}
