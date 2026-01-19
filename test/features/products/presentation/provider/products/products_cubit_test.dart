import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/products.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductsRepository extends Mock implements ProductsRepository {}

void main() {
  group('ProductsCubit', () {
    late MockProductsRepository repository;

    setUp(() {
      repository = MockProductsRepository();
    });

    test('initial state is ProductsState with ready status', () {
      final cubit = ProductsCubit(repository);
      expect(cubit.state.status, Status.ready);
      expect(cubit.state.products, isNull);
    });

    blocTest<ProductsCubit, ProductsState>(
      'emits [loading, success] when getProducts succeeds',
      build: () {
        final products = [
          const PhysicalProduct(id: '1', name: 'Product 1', value: 100.0),
          const ServiceProduct(id: '2', name: 'Service 1', value: 200.0),
        ];
        when(() => repository.getProducts()).thenAnswer((_) async => products);
        return ProductsCubit(repository);
      },
      act: (cubit) => cubit.getProducts(),
      expect: () => [
        const ProductsState(status: Status.loading),
        ProductsState(
          status: Status.success,
          products: const [
            PhysicalProduct(id: '1', name: 'Product 1', value: 100.0),
            ServiceProduct(id: '2', name: 'Service 1', value: 200.0),
          ],
        ),
      ],
      verify: (_) {
        verify(() => repository.getProducts()).called(1);
      },
    );

    blocTest<ProductsCubit, ProductsState>(
      'emits [loading, error] when getProducts fails',
      build: () {
        when(() => repository.getProducts())
            .thenThrow(Exception('Error fetching products'));
        return ProductsCubit(repository);
      },
      act: (cubit) => cubit.getProducts(),
      expect: () => [
        const ProductsState(status: Status.loading),
        const ProductsState(status: Status.error),
      ],
      verify: (_) {
        verify(() => repository.getProducts()).called(1);
      },
    );

    blocTest<ProductsCubit, ProductsState>(
      'emits [loading, success] with empty list when no products',
      build: () {
        when(() => repository.getProducts()).thenAnswer((_) async => []);
        return ProductsCubit(repository);
      },
      act: (cubit) => cubit.getProducts(),
      expect: () => [
        const ProductsState(status: Status.loading),
        const ProductsState(status: Status.success, products: []),
      ],
      verify: (_) {
        verify(() => repository.getProducts()).called(1);
      },
    );
  });
}