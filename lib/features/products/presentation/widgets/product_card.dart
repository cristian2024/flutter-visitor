import 'package:flutter/material.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/products.dart';



/// ------------------------------------------------------------
/// ProductCard
/// ------------------------------------------------------------
///
/// Widget visual que representa un producto individual.
///
/// Se encarga de mostrar:
/// - El tipo de producto mediante una etiqueta visual.
/// - La imagen asociada al producto (si existe).
/// - El nombre del producto.
/// - El valor formateado como moneda.
/// - Un botón para agregar el producto.
///
/// ------------------------------------------------------------
/// Parámetros del constructor:
/// ------------------------------------------------------------
/// * [item]
///   Instancia de `Product` que contiene la información
///   del producto a mostrar.
///
/// * [onAddItem]
///   Callback ejecutado cuando el usuario presiona el botón
///   para agregar el producto.
/// ------------------------------------------------------------

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.item,
    required this.onAddItem,
  });

  final Product item;
  final VoidCallback onAddItem;
  

  @override
  Widget build(BuildContext context) {
    final Product(:imageLink, :name, :value) = item;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                ProductTypeTag(product: item),
              ],
            ),
            SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(4),
              child: imageLink != null
                  ? Image.network(imageLink)
                  : Icon(Icons.question_mark_outlined),
            ),
            SizedBox(height: 4),
            Text(
              name,
              style: textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Text(value.formatCurrency()),
            ElevatedButton(
              onPressed: onAddItem,
              child: Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }
}
