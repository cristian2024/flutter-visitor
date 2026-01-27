import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/cart.dart';

/// ------------------------------------------------------------
/// CartScreen
/// ------------------------------------------------------------
///
/// Pantalla encargada de mostrar el contenido del carrito
/// de compras y el resumen de la transacción.
/// ------------------------------------------------------------
/// Funcionalidad:
/// ------------------------------------------------------------
/// - Muestra la lista de productos agregados al carrito.
/// - Permite incrementar o disminuir la cantidad de cada producto.
/// - Calcula y presenta:
///   - Descuento total.
///   - Impuestos totales.
///   - Valor final de la compra.
/// - Cierra automáticamente la pantalla cuando el carrito
///   queda vacío.
/// ------------------------------------------------------------
/// Estado y control:
/// ------------------------------------------------------------
/// - Consume el estado de `CartCubit`.
/// - Escucha cambios para detectar cuando la cantidad total
///   de ítems llega a cero.
/// ------------------------------------------------------------
/// Navegación:
/// ------------------------------------------------------------
/// - `routeName` define el identificador de ruta de la pantalla.
/// ------------------------------------------------------------
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const String routeName = "cart";

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    try {
      return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: BlocConsumer<CartCubit, CartState>(
              listenWhen: (previous, current) {
                return current.itemsQuantity == 0;
              },
              listener: (context, state) {
                Navigator.pop(context);
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: state.productsWithQuantity.keys.map(
                            (product) {
                              return ProductCartCard(
                                item: product,
                                quantity: state.productsWithQuantity[product]!,
                                onAddItem: () {
                                  context.read<CartCubit>().addItem(product);
                                },
                                onRemoveItem: () {
                                  context.read<CartCubit>().removeItem(product);
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    Divider(),
                    RichText(
                      text: TextSpan(
                        text: "Descuento total: ",
                        style: textTheme.labelLarge,
                        children: [
                          TextSpan(
                            text: (-state.totalDiscount)
                                .formatCurrency()
                                .toString(),
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Impuestos totales: ",
                        style: textTheme.labelLarge,
                        children: [
                          TextSpan(
                            text: state.totalTaxes.formatCurrency().toString(),
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Valor total: ",
                        style: textTheme.labelLarge,
                        children: [
                          TextSpan(
                            text: state.totalValue.formatCurrency().toString(),
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),

                    Divider(),
                    ElevatedButton(
                      onPressed: () async{
                        
                        await showDialog(
                          context: context,
                          builder: (context) => const AlertSuccessfulPurchase(),
                        );
                        context.read<CartCubit>().clearCart();
                      },
                      child: Text('Comprar'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    } catch (e) {
      print("e");
      return Container();
    }
  }
}
