import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/products.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._productsRepository) : super(const ProductsState());

  final ProductsRepository _productsRepository;

  Future<void> getProducts() async {
    emit(state.copyWith(status: Status.loading));

    try {
      final products = await _productsRepository.getProducts();

      emit(
        state.copyWith(
          status: Status.success,
          products: products,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: Status.error),
      );
    }
  }
}
