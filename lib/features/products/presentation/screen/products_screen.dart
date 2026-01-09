import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/products.dart';

/// ------------------------------------------------------------
/// ProductsScreen
/// ------------------------------------------------------------
///
/// Pantalla principal encargada de mostrar el catálogo
/// de productos.
///
/// Esta pantalla:
/// - Provee una instancia de `ProductsCubit` al árbol de widgets.
/// - Inicializa la carga de productos al momento de creación.
/// - Delega la visualización del contenido a `ProductBody`.
/// ------------------------------------------------------------
/// Navegación:
/// ------------------------------------------------------------
/// - `routeName` define el identificador de ruta de la pantalla.
/// ------------------------------------------------------------
/// Parámetros del constructor:
/// ------------------------------------------------------------
/// * [onAddProduct]
///   Callback ejecutado cuando se agrega un producto al carrito.
///
/// * [onNavigateToCart]
///   Callback ejecutado para navegar a la pantalla del carrito.
///
/// * [productsInCart]
///   Cantidad de productos actualmente en el carrito.
///   Se utiliza para mostrar el contador correspondiente.
/// ------------------------------------------------------------
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
