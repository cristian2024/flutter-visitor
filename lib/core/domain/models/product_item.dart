import 'package:equatable/equatable.dart';
import 'package:flutter_visitor/core.dart';

class ProductItem extends Equatable {
  final Product product;
  final int quantity;

  const ProductItem({required this.product, required this.quantity});

  bool get hasAvailability => quantity > 0;
  bool get hasNotItems => quantity == 0;

  @override
  List<Object?> get props => [product, quantity];
}
