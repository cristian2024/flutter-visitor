part of 'products_cubit.dart';

/// ------------------------------------------------------------
/// ProductsState
/// ------------------------------------------------------------
///
/// Estado que representa la información y el estado actual
/// del módulo de productos.
/// ------------------------------------------------------------
/// Propiedades:
/// ------------------------------------------------------------
/// * [status]
///   Representa el estado actual del proceso de obtención
///   de productos (por ejemplo: ready, loading, success, error).
///
/// * [products]
///   Lista de productos obtenidos desde el repositorio.
///   Puede ser `null` cuando aún no se han cargado.
/// ------------------------------------------------------------
/// Comportamiento:
/// ------------------------------------------------------------
/// - Extiende `Equatable` para permitir comparaciones
///   eficientes entre estados.
/// - Provee el método `copyWith` para crear nuevas
///   instancias del estado de forma inmutable.
/// ------------------------------------------------------------

class ProductsState extends Equatable {
  const ProductsState({this.status = Status.ready, this.products});

  final Status status;
  final List<Product>? products;

  ProductsState copyWith({Status? status, List<Product>? products}) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [status, products];
}
