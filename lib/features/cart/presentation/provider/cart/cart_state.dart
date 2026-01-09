part of 'cart_cubit.dart';

/// ------------------------------------------------------------
/// CartState
/// ------------------------------------------------------------
///
/// Estado que representa la información actual del carrito
/// de compras.
/// ------------------------------------------------------------
/// Propiedades:
/// ------------------------------------------------------------
/// * [productsWithQuantity]
///   Mapa que relaciona cada `Product` con la cantidad
///   correspondiente en el carrito.
///   Se utiliza `Product` como clave aprovechando `Equatable`.
/// ------------------------------------------------------------
/// Propiedades derivadas:
/// ------------------------------------------------------------
/// * [itemsQuantity]
///   Cantidad total de ítems en el carrito.
///
/// * [totalDiscount]
///   Descuento total aplicado al carrito.
///   Calculado mediante `DiscountsVisitor`.
///
/// * [totalTaxes]
///   Impuestos totales del carrito.
///   Calculados mediante `TaxesVisitor`.
///
/// * [totalValue]
///   Valor final total del carrito.
///   Calculado mediante `FinalPriceVisitor`.
/// ------------------------------------------------------------
/// Comportamiento:
/// ------------------------------------------------------------
/// - Extiende `Equatable` para permitir comparaciones eficientes.
/// - Provee `copyWith` para la actualización inmutable del estado.
/// - Centraliza la lógica de cálculo del resumen del carrito.
/// ------------------------------------------------------------

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
