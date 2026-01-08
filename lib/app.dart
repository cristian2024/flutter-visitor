import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_visitor/core.dart';
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
      ],
      child: MaterialApp(
        initialRoute: ProductsScreen.routeName,
        routes: {ProductsScreen.routeName: (_) => ProductsScreen()},
      ),
    );
  }
}
