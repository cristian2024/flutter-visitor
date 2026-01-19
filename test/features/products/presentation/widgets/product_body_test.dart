import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/products.dart';

import '../../../../common/rich_text_test.dart';

class MockProductsCubit extends MockCubit<ProductsState>
    implements ProductsCubit {}

void main() {
  group('ProductsBody', () {
    late MockProductsCubit mockProductsCubit;

    setUp(() {
      mockProductsCubit = MockProductsCubit();
    });

    Widget buildProductsScreen({
      void Function(Product)? onAddProduct,
      VoidCallback? onNavigateToCart,
      int productsInCart = 0,
    }) {
      return BlocProvider<ProductsCubit>(
        create: (context) => mockProductsCubit,
        child: MaterialApp(
          home: ProductBody(
            onAddProduct: onAddProduct ?? (_) {},
            onNavigateToCart: onNavigateToCart ?? () {},
            productsInCart: productsInCart,
          ),
        ),
      );
    }

    testWidgets('displays products when state is success', (tester) async {
      final products = [
        const PhysicalProduct(
          id: '1',
          name: 'Product 1',
          value: 200.0,
        ),
        const ServiceProduct(
          id: '2',
          name: 'Service 1',
          value: 150.0,
        ),
      ];

      final state = ProductsState(
        status: Status.success,
        products: products,
      );

      whenListen(
        mockProductsCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(buildProductsScreen());
      await tester.pumpAndSettle();

      expect(find.richTextContaining('Product 1'), findsOneWidget);
      expect(find.richTextContaining('Service 1'), findsOneWidget);
    });

    testWidgets('displays nothing when products list is null', (tester) async {
      final state = const ProductsState(
        status: Status.ready,
        products: null,
      );

      whenListen(
        mockProductsCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(buildProductsScreen());
      await tester.pumpAndSettle();

      expect(find.byType(ProductCard), findsNothing);
    });

    testWidgets('displays nothing when products list is empty', (tester) async {
      final state = const ProductsState(
        status: Status.success,
        products: [],
      );

      whenListen(
        mockProductsCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(buildProductsScreen());
      await tester.pumpAndSettle();

      expect(find.byType(ProductCard), findsNothing);
    });

    testWidgets('calls onAddProduct when add button is pressed', (
      tester,
    ) async {
      Product? addedProduct;
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product 1',
        value: 200.0,
      );

      final state = ProductsState(
        status: Status.success,
        products: [product],
      );

      whenListen(
        mockProductsCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(
        buildProductsScreen(
          onAddProduct: (p) => addedProduct = p,
        ),
      );
      await tester.pumpAndSettle();

      final addButton = find.text('Agregar');
      expect(addButton, findsOneWidget);

      await tester.tap(addButton);
      await tester.pump();

      expect(addedProduct, product);
    });

    testWidgets('displays floating action button when cart has items', (
      tester,
    ) async {
      final state = const ProductsState(
        status: Status.success,
        products: [],
      );

      whenListen(
        mockProductsCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(buildProductsScreen(productsInCart: 3));
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('does not display floating action button when cart is empty', (
      tester,
    ) async {
      final state = const ProductsState(
        status: Status.success,
        products: [],
      );

      whenListen(
        mockProductsCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(buildProductsScreen(productsInCart: 0));
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets('calls onNavigateToCart when FAB is pressed', (tester) async {
      bool navigateCalled = false;
      final state = const ProductsState(
        status: Status.success,
        products: [],
      );

      whenListen(
        mockProductsCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(
        buildProductsScreen(
          productsInCart: 1,
          onNavigateToCart: () => navigateCalled = true,
        ),
      );
      await tester.pumpAndSettle();

      final fab = find.byType(FloatingActionButton);
      await tester.tap(fab);
      await tester.pump();

      expect(navigateCalled, true);
    });

    testWidgets('displays product values correctly', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Test Product',
        value: 350000,
      );

      final state = ProductsState(
        status: Status.success,
        products: [product],
      );

      whenListen(
        mockProductsCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(buildProductsScreen());
      await tester.pumpAndSettle();

      expect(find.text('\$350.000'), findsOneWidget);
    });

    testWidgets('displays product type tags correctly', (tester) async {
      final products = [
        const PhysicalProduct(id: '1', name: 'Physical', value: 100.0),
        const ServiceProduct(id: '2', name: 'Service', value: 100.0),
        const ImportedProduct(id: '3', name: 'Imported', value: 100.0),
      ];

      final state = ProductsState(
        status: Status.success,
        products: products,
      );

      whenListen(
        mockProductsCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(buildProductsScreen());
      await tester.pumpAndSettle();

      expect(find.text('Fisico'), findsOneWidget);
      expect(find.text('Servicio'), findsOneWidget);
      expect(find.text('Importado'), findsOneWidget);
    });

    testWidgets('displays multiple products in grid layout', (tester) async {
      final products = List.generate(
        6,
        (index) => PhysicalProduct(
          id: '$index',
          name: 'Product $index',
          value: 100.0 * (index + 1),
        ),
      );

      final state = ProductsState(
        status: Status.success,
        products: products,
      );

      whenListen(
        mockProductsCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(buildProductsScreen());
      await tester.pumpAndSettle();

      expect(find.byType(ProductCard), findsNWidgets(6));
    });
  });
}
