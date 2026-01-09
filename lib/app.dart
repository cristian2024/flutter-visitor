import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/cart.dart';
import 'package:flutter_visitor/features/products.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsCubit(
            readIt(),
          )..getProducts(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => CartCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            initialRoute: ProductsScreen.routeName,
            routes: {
              CartScreen.routeName: (_) {
                return CartScreen();
              },
              ProductsScreen.routeName: (_) {
                return BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return ProductsScreen(
                      onNavigateToCart: () {
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                      productsInCart: state.itemsQuantity,
                      onAddProduct: (item) {
                        context.read<CartCubit>().addItem(item);
                      },
                    );
                  },
                );
              },
            },
          );
        },
      ),
    );
  }
}
