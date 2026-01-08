import 'package:flutter/material.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/products.dart';
import 'package:intl/intl.dart';

final formatter = NumberFormat.currency(
  locale: 'es_CO',
  symbol: '\$',
  decimalDigits: 0,
  customPattern: '¤#,##0',
);

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.item});

  final ProductItem item;

  @override
  Widget build(BuildContext context) {
    final ProductItem(
      :product,
      :quantity,
    ) = item;
    final Product(:imageLink, :name, :value) = product;
    final textTheme = Theme.of(context).textTheme;

    

    final String quantities = quantity > 1
        ? 'unidades disponibles'
        : 'unidad disponible';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                ProductTypeTag(product: product),
              ],
            ),
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
            Text(formatter.format(value)),
            Text(
              '$quantity $quantities',
              style: textTheme.labelMedium,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }
}
