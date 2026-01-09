import 'package:flutter/material.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/cart.dart';
import 'package:flutter_visitor/features/products.dart';

/// ------------------------------------------------------------
/// ProductCartCard
/// ------------------------------------------------------------
///
/// Widget visual que representa un producto dentro del carrito
/// de compras.
/// ------------------------------------------------------------
/// Funcionalidad:
/// ------------------------------------------------------------
/// - Muestra la información básica del producto.
/// - Indica la cantidad seleccionada.
/// - Calcula y presenta:
///   - Precio unitario.
///   - Precio total según cantidad.
///   - Descuentos aplicados.
///   - Impuestos.
///   - Precio final.
/// - Permite aumentar o disminuir la cantidad del producto.
/// ------------------------------------------------------------
/// Integración:
/// ------------------------------------------------------------
/// - Utiliza el patrón Visitor para calcular descuentos,
///   impuestos y precio final (`DiscountsVisitor`,
///   `TaxesVisitor`, `FinalPriceVisitor`).
/// ------------------------------------------------------------
/// Parámetros del constructor:
/// ------------------------------------------------------------
/// * [item]
///   Instancia de `Product` que representa el producto
///   en el carrito.
///
/// * [quantity]
///   Cantidad actual del producto.
///
/// * [onAddItem]
///   Callback ejecutado para incrementar la cantidad.
///
/// * [onRemoveItem]
///   Callback ejecutado para disminuir la cantidad.
/// ------------------------------------------------------------

class ProductCartCard extends StatelessWidget {
  const ProductCartCard({
    super.key,
    required this.item,
    required this.onAddItem,
    required this.onRemoveItem,
    required this.quantity,
  });

  final Product item;
  final int quantity;
  final VoidCallback onAddItem;
  final VoidCallback onRemoveItem;

  @override
  Widget build(BuildContext context) {
    final Product(:imageLink, :name, :value) = item;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ProductTypeTag(product: item),
                  ],
                ),
                SizedBox(height: 4),
                SizedBox(
                  height: 96,
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(4),
                    child: imageLink != null
                        ? Image.network(imageLink)
                        : Icon(Icons.question_mark_outlined),
                  ),
                ),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: name,
                      style: textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: '\t\tx$quantity',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(item.value.formatCurrency()),
                          Icon(Icons.arrow_forward),
                          Text((item.value * quantity).formatCurrency()),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Descuento: ",
                          style: textTheme.titleSmall,
                          children: [
                            TextSpan(
                              text:
                                  (-item.accept(DiscountsVisitor()) * quantity)
                                      .formatCurrency(),
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Impuestos: ",
                          style: textTheme.titleSmall,
                          children: [
                            TextSpan(
                              text: (item.accept(TaxesVisitor()) * quantity)
                                  .formatCurrency(),
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Total: ",
                          style: textTheme.titleSmall,
                          children: [
                            TextSpan(
                              text:
                                  (item.accept(FinalPriceVisitor()) * quantity)
                                      .formatCurrency(),
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: onRemoveItem,
                        icon: Icon(Icons.remove),
                      ),
                      IconButton(
                        onPressed: onAddItem,
                        icon: Icon(Icons.check),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
