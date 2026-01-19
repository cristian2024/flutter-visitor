import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/products.dart';

void main() {
  group('ProductCard', () {
    Widget buildProductCard({
      required Product item,
      VoidCallback? onAddItem,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: ProductCard(
            item: item,
            onAddItem: onAddItem ?? () {},
          ),
        ),
      );
    }

    testWidgets('displays product name', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Test Product',
        value: 200.0,
      );

      await tester.pumpWidget(buildProductCard(item: product));
      await tester.pumpAndSettle();

      expect(find.text('Test Product'), findsOneWidget);
    });

    testWidgets('displays product value formatted as currency', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product',
        value: 350000,
      );

      await tester.pumpWidget(buildProductCard(item: product));
      await tester.pumpAndSettle();

      expect(find.text('\$350.000'), findsOneWidget);
    });

    testWidgets('displays add button with text "Agregar"', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product',
        value: 100.0,
      );

      await tester.pumpWidget(buildProductCard(item: product));
      await tester.pumpAndSettle();

      expect(find.text('Agregar'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('calls onAddItem when add button is pressed', (tester) async {
      bool addCalled = false;
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product',
        value: 100.0,
      );

      await tester.pumpWidget(buildProductCard(
        item: product,
        onAddItem: () => addCalled = true,
      ));
      await tester.pumpAndSettle();

      final addButton = find.text('Agregar');
      await tester.tap(addButton);

      expect(addCalled, true);
    });

    testWidgets('displays ProductTypeTag for physical product', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Physical Product',
        value: 100.0,
      );

      await tester.pumpWidget(buildProductCard(item: product));
      await tester.pumpAndSettle();

      expect(find.byType(ProductTypeTag), findsOneWidget);
      expect(find.text('Fisico'), findsOneWidget);
    });

    testWidgets('displays ProductTypeTag for service product', (tester) async {
      final product = const ServiceProduct(
        id: '2',
        name: 'Service Product',
        value: 100.0,
      );

      await tester.pumpWidget(buildProductCard(item: product));
      await tester.pumpAndSettle();

      expect(find.text('Servicio'), findsOneWidget);
    });

    testWidgets('displays ProductTypeTag for imported product',
        (tester) async {
      final product = const ImportedProduct(
        id: '3',
        name: 'Imported Product',
        value: 100.0,
      );

      await tester.pumpWidget(buildProductCard(item: product));
      await tester.pumpAndSettle();

      expect(find.text('Importado'), findsOneWidget);
    });

    testWidgets('displays icon when imageLink is null', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product',
        value: 100.0,
        imageLink: null,
      );

      await tester.pumpWidget(buildProductCard(item: product));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.question_mark_outlined), findsOneWidget);
    });

    testWidgets('displays product with description', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product with description',
        value: 100.0,
        description: 'This is a test description',
      );

      await tester.pumpWidget(buildProductCard(item: product));
      await tester.pumpAndSettle();

      expect(find.text('Product with description'), findsOneWidget);
    });

    testWidgets('displays card widget', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product',
        value: 100.0,
      );

      await tester.pumpWidget(buildProductCard(item: product));
      await tester.pumpAndSettle();

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('displays multiple values correctly', (tester) async {
      final products = [
        const PhysicalProduct(id: '1', name: 'P1', value: 200.0),
        const PhysicalProduct(id: '2', name: 'P2', value: 1500.0),
        const PhysicalProduct(id: '3', name: 'P3', value: 4800000.0),
      ];

      for (final product in products) {
        await tester.pumpWidget(buildProductCard(item: product));
        await tester.pumpAndSettle();

        if (product.value == 200.0) {
          expect(find.text('\$200'), findsOneWidget);
        } else if (product.value == 1500.0) {
          expect(find.text('\$1.500'), findsOneWidget);
        } else if (product.value == 4800000.0) {
          expect(find.text('\$4.800.000'), findsOneWidget);
        }
      }
    });
  });
}