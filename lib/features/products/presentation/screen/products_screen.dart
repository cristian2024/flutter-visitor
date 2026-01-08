import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_visitor/features/products.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  static const String routeName = "products";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                maxWidth: constraints.maxWidth/2
                              ),
                              child: ProductCard(item: product),
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
