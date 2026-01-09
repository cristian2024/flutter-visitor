import 'package:flutter/material.dart';
import 'package:flutter_visitor/core.dart';

/// ------------------------------------------------------------
/// ProductTypeTag
/// ------------------------------------------------------------
///
/// Widget visual que muestra una etiqueta (`Chip`) indicando
/// el tipo de producto.
///
/// El texto de la etiqueta se determina dinámicamente según
/// el tipo concreto de `Product`.
/// ------------------------------------------------------------
/// Tipos soportados:
/// ------------------------------------------------------------
/// - `ImportedProduct` → "Importado"
/// - `PhysicalProduct` → "Fisico"
/// - `ServiceProduct`  → "Servicio"
/// ------------------------------------------------------------
/// Parámetros del constructor:
/// ------------------------------------------------------------
/// * [product]
///   Instancia de `Product` utilizada para determinar
///   el tipo y el texto que se mostrará en la etiqueta.
/// ------------------------------------------------------------
class ProductTypeTag extends StatelessWidget {
  const ProductTypeTag({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      label: Text(typeTitle),
      padding: EdgeInsets.zero,
    );
  }

  String get typeTitle {
    return switch (product) {
      ImportedProduct() => "Importado",
      PhysicalProduct() => "Fisico",
      ServiceProduct() => "Servicio",
      _ => "",
    };
  }
}
