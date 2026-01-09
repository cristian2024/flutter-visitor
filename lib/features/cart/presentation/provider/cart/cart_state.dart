part of 'cart_cubit.dart';

class CartState extends Equatable {
  const CartState({
    this.productsWithQuantity = const {},
  });

  final Map<Product, int>
  productsWithQuantity; //using [Product] as key taking advantage of equatable

  CartState copyWith({Map<Product, int>? productsWithQuantity}) {
    return CartState(
      productsWithQuantity: productsWithQuantity ?? this.productsWithQuantity,
    );
  }

  int get itemsQuantity {
    return productsWithQuantity.values.fold(0, (p, e) => p + e);
  }

  double get totalDiscount {
    final visitor = DiscountsVisitor();
    return productsWithQuantity.keys.fold(
      0,
      (pre, item) => pre + (item.accept(visitor) * productsWithQuantity[item]!),
    );
  }

  double get totalTaxes {
    final visitor = TaxesVisitor();
    return productsWithQuantity.keys.fold(
      0,
      (pre, item) => pre + (item.accept(visitor) * productsWithQuantity[item]!),
    );
  }

  double get totalValue {
    final visitor = FinalPriceVisitor();
    return productsWithQuantity.keys.fold(
      0,
      (pre, item) => pre + (item.accept(visitor) * productsWithQuantity[item]!),
    );
  }

  @override
  List<Object> get props => [productsWithQuantity];
}
