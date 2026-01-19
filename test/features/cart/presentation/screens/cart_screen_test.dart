import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/cart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../common/rich_text_test.dart';

class MockCartCubit extends MockCubit<CartState> implements CartCubit {}

void main() {
  group('CartScreen', () {
    late MockCartCubit mockCartCubit;
    late Product product;

    setUp(() {
      product = const PhysicalProduct(
        id: '1',
        name: 'Product 1',
        value: 200.0,
      );
      mockCartCubit = MockCartCubit();
    });

    Widget buildCartScreen() {
      return MaterialApp(
        home: BlocProvider<CartCubit>.value(
          value: mockCartCubit,
          child: const CartScreen(),
        ),
      );
    }

    testWidgets('displays cart items correctly', (tester) async {
      final product2 = const ServiceProduct(
        id: '2',
        name: 'Service 1',
        value: 150.0,
      );

      final state = CartState(
        productsWithQuantity: {
          product: 2,
          product2: 1,
        },
      );

      whenListen(
        mockCartCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(buildCartScreen());
      await tester.pump();
      await tester.pump();
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.richTextContaining('Product 1'), findsOneWidget);
      expect(find.richTextContaining('Service 1'), findsOneWidget);
    });

    testWidgets('displays total discount correctly', (tester) async {
      final state = CartState(
        productsWithQuantity: {product: 1},
      );

      whenListen(
        mockCartCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(buildCartScreen());
      await tester.pumpAndSettle();

      expect(find.richTextContaining('Descuento total: -\$20'), findsOneWidget);
    });

    testWidgets('displays total taxes correctly', (tester) async {
      final state = CartState(
        productsWithQuantity: {product: 1},
      );

      whenListen(
        mockCartCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(buildCartScreen());
      await tester.pumpAndSettle();

      expect(find.richTextContaining('Impuestos totales: \$38'), findsOneWidget);

    });

    testWidgets('displays total value correctly', (tester) async {
      final state = CartState(
        productsWithQuantity: {product: 1},
      );

      whenListen(
        mockCartCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(buildCartScreen());
      await tester.pumpAndSettle();

      expect(find.richTextContaining('Valor total: \$218'), findsOneWidget);
    });

    testWidgets('calls addItem when add button is pressed', (tester) async {
      final state = CartState(
        productsWithQuantity: {product: 1},
      );

      whenListen(
        mockCartCubit,
        Stream.value(state),
        initialState: state,
      );
      when(() => mockCartCubit.addItem(product)).thenReturn(null);

      await tester.pumpWidget(buildCartScreen());
      await tester.pumpAndSettle();

      final addButton = find.byIcon(Icons.check);
      expect(addButton, findsOneWidget);

      await tester.tap(addButton);
      await tester.pump();

      verify(() => mockCartCubit.addItem(product)).called(1);
    });

    testWidgets('calls removeItem when remove button is pressed', (
      tester,
    ) async {
      final state = CartState(
        productsWithQuantity: {product: 1},
      );

      whenListen(
        mockCartCubit,
        Stream.value(state),
        initialState: state,
      );
      when(() => mockCartCubit.removeItem(product)).thenReturn(null);

      await tester.pumpWidget(buildCartScreen());
      await tester.pumpAndSettle();

      final removeButton = find.byIcon(Icons.remove);
      expect(removeButton, findsOneWidget);

      await tester.tap(removeButton);
      await tester.pump();

      verify(() => mockCartCubit.removeItem(product)).called(1);
    });

    testWidgets('displays buy button', (tester) async {
      final state = CartState(
        productsWithQuantity: {product: 1},
      );

      whenListen(
        mockCartCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpWidget(buildCartScreen());
      await tester.pumpAndSettle();

      expect(find.text('Comprar'), findsOneWidget);
    });

    testWidgets('pops navigation when cart becomes empty', (tester) async {
      final initialState = CartState(
        productsWithQuantity: {product: 1},
      );
      final emptyState = const CartState(productsWithQuantity: {});

      whenListen(
        mockCartCubit,
        Stream.fromIterable([emptyState]),
        initialState: initialState,
      );

      await tester.pumpWidget(buildCartScreen());
      await tester.pump();

      expect(find.byType(CartScreen), findsOneWidget);

      await tester.pump();
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byType(CartScreen), findsNothing);
    });
  });
}


