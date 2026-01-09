import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/products.dart';

class ProductBody extends StatelessWidget {
  const ProductBody({
    super.key,
    required this.onAddProduct,
    required this.onNavigateToCart,
    this.productsInCart = 0,
  });

  final void Function(Product item) onAddProduct;
  final VoidCallback onNavigateToCart;
  final int productsInCart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: productsInCart > 0
          ? Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                FloatingActionButton(
                  onPressed: onNavigateToCart,
                  child: Icon(Icons.shopping_cart_outlined),
                ),
                Text(
                  productsInCart.toString(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  final ProductsState(:products) = state;
                  if (products != null) {
                    return SingleChildScrollView(
                      child: Wrap(
                        children: products.map(
                          (product) {
                            return ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth / 2,
                              ),
                              child: ProductCard(
                                item: product,
                                onAddItem: () {
                                  onAddProduct(product);
                                },
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    );
                  }

                  return SizedBox.shrink();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
