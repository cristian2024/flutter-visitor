import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/cart.dart';

import '../../../../common/rich_text.dart';


void main() {
  group('ProductCartCard', () {
    Widget buildProductCartCard({
      required Product item,
      int quantity = 1,
      VoidCallback? onAddItem,
      VoidCallback? onRemoveItem,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: ProductCartCard(
            item: item,
            quantity: quantity,
            onAddItem: onAddItem ?? () {},
            onRemoveItem: onRemoveItem ?? () {},
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

      await tester.pumpWidget(buildProductCartCard(item: product));
      await tester.pumpAndSettle();

      expect(find.richTextContaining('Test Product'), findsOneWidget);
    });

    testWidgets('displays product quantity', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product 1',
        value: 200.0,
      );

      await tester.pumpWidget(buildProductCartCard(
        item: product,
        quantity: 3,
      ));
      await tester.pumpAndSettle();

      expect(find.richTextContaining('x3'), findsOneWidget);
    });

    testWidgets('displays unit price and total price', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product 1',
        value: 200.0,
      );

      await tester.pumpWidget(buildProductCartCard(
        item: product,
        quantity: 2,
      ));
      await tester.pumpAndSettle();

      expect(find.text('\$200'), findsOneWidget);
      expect(find.text('\$400'), findsOneWidget);
    });

    testWidgets('displays discount for physical product', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product 1',
        value: 200.0,
      );

      await tester.pumpWidget(buildProductCartCard(
        item: product,
        quantity: 1,
      ));
      await tester.pumpAndSettle();

      expect(find.richTextContaining('Descuento: '), findsOneWidget);
      expect(find.richTextContaining('-\$20'), findsOneWidget);
    });

    testWidgets('displays taxes for physical product', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product 1',
        value: 200.0,
      );

      await tester.pumpWidget(buildProductCartCard(
        item: product,
        quantity: 1,
      ));
      await tester.pumpAndSettle();

      expect(find.richTextContaining('Impuestos: '), findsOneWidget);
      expect(find.richTextContaining('\$38'), findsOneWidget);
    });

    testWidgets('displays final price for physical product', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product 1',
        value: 200.0,
      );

      await tester.pumpWidget(buildProductCartCard(
        item: product,
        quantity: 1,
      ));
      await tester.pumpAndSettle();

      expect(find.richTextContaining('Total: '), findsOneWidget);
      expect(find.richTextContaining('\$218'), findsOneWidget);
    });

    testWidgets('displays discount for service product', (tester) async {
      final product = const ServiceProduct(
        id: '2',
        name: 'Service 1',
        value: 150.0,
      );


      await tester.pumpWidget(buildProductCartCard(
        item: product,
        quantity: 1,
      ));
      await tester.pumpAndSettle();

      expect(find.richTextContaining('-\$8'), findsOneWidget);
    });

    testWidgets('displays no discount for imported product', (tester) async {
      final product = const ImportedProduct(
        id: '3',
        name: 'Imported Product',
        value: 1000.0,
      );

      await tester.pumpWidget(buildProductCartCard(
        item: product,
        quantity: 1,
      ));
      await tester.pumpAndSettle();

      expect(find.richTextContaining('-\$0'), findsOneWidget);
    });

    testWidgets('displays taxes for imported product (24%)', (tester) async {
      final product = const ImportedProduct(
        id: '3',
        name: 'Imported Product',
        value: 1000.0,
      );

      await tester.pumpWidget(buildProductCartCard(
        item: product,
        quantity: 1,
      ));
      await tester.pumpAndSettle();

      expect(find.richTextContaining('\$240'), findsOneWidget);
    });

    testWidgets('calls onAddItem when add button is pressed', (tester) async {
      bool addCalled = false;
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product 1',
        value: 200.0,
      );

      await tester.pumpWidget(buildProductCartCard(
        item: product,
        onAddItem: () => addCalled = true,
      ));
      await tester.pumpAndSettle();

      final addButton = find.byIcon(Icons.check);
      await tester.tap(addButton);

      expect(addCalled, true);
    });

    testWidgets('calls onRemoveItem when remove button is pressed',
        (tester) async {
      bool removeCalled = false;
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product 1',
        value: 200.0,
      );

      await tester.pumpWidget(buildProductCartCard(
        item: product,
        onRemoveItem: () => removeCalled = true,
      ));
      await tester.pumpAndSettle();

      final removeButton = find.byIcon(Icons.remove);
      await tester.tap(removeButton);

      expect(removeCalled, true);
    });

    testWidgets('calculates correctly with multiple quantity', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product 1',
        value: 200.0,
      );

      await tester.pumpWidget(buildProductCartCard(
        item: product,
        quantity: 2,
      ));
      await tester.pumpAndSettle();

      // Discount: 20 * 2 = 40
      expect(find.richTextContaining('-\$40'), findsOneWidget);
      // Taxes: 38 * 2 = 76
      expect(find.richTextContaining('\$76'), findsOneWidget);
      // Total: 218 * 2 = 436
      expect(find.richTextContaining('\$436'), findsOneWidget);
    });

    testWidgets('displays product type tag', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product 1',
        value: 200.0,
      );

      await tester.pumpWidget(buildProductCartCard(item: product));
      await tester.pumpAndSettle();

      expect(find.text('Fisico'), findsOneWidget);
    });

    testWidgets('displays add and remove buttons', (tester) async {
      final product = const PhysicalProduct(
        id: '1',
        name: 'Product 1',
        value: 200.0,
      );

      await tester.pumpWidget(buildProductCartCard(item: product));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });
  });
}