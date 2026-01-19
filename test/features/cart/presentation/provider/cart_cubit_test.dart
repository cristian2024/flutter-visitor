import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/cart.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('CartCubit', () {
    late CartCubit cubit;

    setUp(() {
      cubit = CartCubit();
    });

    test('initial state is empty CartState', () {
      expect(cubit.state.productsWithQuantity, isEmpty);
      expect(cubit.state.itemsQuantity, 0);
      expect(cubit.state.totalDiscount, 0);
      expect(cubit.state.totalTaxes, 0);
      expect(cubit.state.totalValue, 0);
    });

    group('addItem', () {
      blocTest<CartCubit, CartState>(
        'adds new product with quantity 1',
        build: () => CartCubit(),
        act: (cubit) {
          final product = const PhysicalProduct(
            id: '1',
            name: 'Product 1',
            value: 200.0,
          );
          cubit.addItem(product);
        },
        expect: () => [
          CartState(
            productsWithQuantity: {
              const PhysicalProduct(id: '1', name: 'Product 1', value: 200.0):
                  1,
            },
          ),
        ],
      );

      blocTest<CartCubit, CartState>(
        'increments quantity when product already exists',
        build: () => CartCubit(),
        act: (cubit) {
          final product = const PhysicalProduct(
            id: '1',
            name: 'Product 1',
            value: 200.0,
          );
          cubit.addItem(product);
          cubit.addItem(product);
        },
        expect: () => [
          CartState(
            productsWithQuantity: {
              const PhysicalProduct(id: '1', name: 'Product 1', value: 200.0):
                  1,
            },
          ),
          CartState(
            productsWithQuantity: {
              const PhysicalProduct(id: '1', name: 'Product 1', value: 200.0):
                  2,
            },
          ),
        ],
      );

      blocTest<CartCubit, CartState>(
        'adds multiple different products',
        build: () => CartCubit(),
        act: (cubit) {
          final product1 = const PhysicalProduct(
            id: '1',
            name: 'Product 1',
            value: 200.0,
          );
          final product2 = const ServiceProduct(
            id: '2',
            name: 'Service 1',
            value: 150.0,
          );
          cubit.addItem(product1);
          cubit.addItem(product2);
        },
        expect: () => [
          CartState(
            productsWithQuantity: {
              const PhysicalProduct(id: '1', name: 'Product 1', value: 200.0):
                  1,
            },
          ),
          CartState(
            productsWithQuantity: {
              const PhysicalProduct(id: '1', name: 'Product 1', value: 200.0):
                  1,
              const ServiceProduct(id: '2', name: 'Service 1', value: 150.0): 1,
            },
          ),
        ],
      );
    });

    group('removeItem', () {
      blocTest<CartCubit, CartState>(
        'decrements quantity when product has more than 1',
        build: () => CartCubit(),
        seed: () => CartState(
          productsWithQuantity: {
            const PhysicalProduct(id: '1', name: 'Product 1', value: 200.0): 2,
          },
        ),
        act: (cubit) {
          final product = const PhysicalProduct(
            id: '1',
            name: 'Product 1',
            value: 200.0,
          );
          cubit.removeItem(product);
        },
        expect: () => [
          CartState(
            productsWithQuantity: {
              const PhysicalProduct(id: '1', name: 'Product 1', value: 200.0):
                  1,
            },
          ),
        ],
      );

      blocTest<CartCubit, CartState>(
        'removes product when quantity is 1',
        build: () => CartCubit(),
        seed: () => CartState(
          productsWithQuantity: {
            const PhysicalProduct(id: '1', name: 'Product 1', value: 200.0): 1,
          },
        ),
        act: (cubit) {
          final product = const PhysicalProduct(
            id: '1',
            name: 'Product 1',
            value: 200.0,
          );
          cubit.removeItem(product);
        },
        expect: () => [
          const CartState(productsWithQuantity: {}),
        ],
      );
    });

    group('CartState calculations', () {
      test('calculates itemsQuantity correctly', () {
        final state = CartState(
          productsWithQuantity: {
            const PhysicalProduct(id: '1', name: 'Product 1', value: 200.0): 2,
            const ServiceProduct(id: '2', name: 'Service 1', value: 150.0): 3,
          },
        );
        expect(state.itemsQuantity, 5);
      });

      test('calculates totalDiscount correctly', () {
        // Physical: 200 * 0.10 * 2 = 40
        // Service: 150 * 0.05 * 1 = 7.5
        // Total: 47.5
        final state = CartState(
          productsWithQuantity: {
            const PhysicalProduct(id: '1', name: 'Product 1', value: 200.0): 2,
            const ServiceProduct(id: '2', name: 'Service 1', value: 150.0): 1,
          },
        );
        expect(state.totalDiscount, 47.5);
      });

      test('calculates totalTaxes correctly', () {
        // Physical: 200 * 0.19 * 2 = 76
        // Service: 150 * 0.19 * 1 = 28.5
        // Total: 104.5
        final state = CartState(
          productsWithQuantity: {
            const PhysicalProduct(id: '1', name: 'Product 1', value: 200.0): 2,
            const ServiceProduct(id: '2', name: 'Service 1', value: 150.0): 1,
          },
        );
        expect(state.totalTaxes, 104.5);
      });

      test('calculates totalValue correctly', () {
        // Physical: (200 + 38 - 20) * 2 = 436
        // Service: (150 + 28.5 - 7.5) * 1 = 171
        // Total: 607
        final state = CartState(
          productsWithQuantity: {
            const PhysicalProduct(id: '1', name: 'Product 1', value: 200.0): 2,
            const ServiceProduct(id: '2', name: 'Service 1', value: 150.0): 1,
          },
        );
        expect(state.totalValue, 607.0);
      });
    });
  });
}
