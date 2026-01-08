part of 'products_cubit.dart';

class ProductsState extends Equatable {
  const ProductsState({this.status = Status.ready, this.products});

  final Status status;
  final List<ProductItem>? products;

  ProductsState copyWith({Status? status, List<ProductItem>? products}) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [status, products];
}
