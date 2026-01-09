import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/products.dart';

part 'products_state.dart';

/// ------------------------------------------------------------
/// ProductsCubit
/// ------------------------------------------------------------
///
/// Cubit responsable de manejar el estado relacionado con
/// la obtención y gestión del listado de productos.
/// ------------------------------------------------------------
/// Responsabilidades:
/// ------------------------------------------------------------
/// - Solicitar los productos al repositorio.
/// - Emitir los estados de carga, éxito y error.
/// - Exponer el estado actual a la capa de presentación.
/// ------------------------------------------------------------
/// Dependencias:
/// ------------------------------------------------------------
/// * [ProductsRepository]
///   Fuente de datos encargada de obtener los productos.
/// ------------------------------------------------------------
/// Estados manejados:
/// ------------------------------------------------------------
/// - `Status.loading`
///   Indica que la obtención de productos está en curso.
///
/// - `Status.success`
///   Indica que los productos fueron obtenidos exitosamente.
///
/// - `Status.error`
///   Indica que ocurrió un error al obtener los productos.
/// ------------------------------------------------------------
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
