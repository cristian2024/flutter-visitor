import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/products.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
    super.key,
    required this.onAddProduct,
    required this.onNavigateToCart,
    this.productsInCart = 0,
  });

  static const String routeName = "products";

  final void Function(Product item) onAddProduct;
  final VoidCallback onNavigateToCart;
  final int productsInCart;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(
        readIt(),
      )..getProducts(),
      lazy: false,
      child: ProductBody(
        productsInCart: productsInCart,
        onAddProduct: onAddProduct,
        onNavigateToCart: onNavigateToCart,
      ),
    );
  }
}
