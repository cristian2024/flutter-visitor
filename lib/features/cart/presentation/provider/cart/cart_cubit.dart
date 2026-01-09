import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/cart/domain/visitors/discounts_visitor.dart';
import 'package:flutter_visitor/features/cart/domain/visitors/final_price_visitor.dart';
import 'package:flutter_visitor/features/cart/domain/visitors/taxes_visitor.dart';

part 'cart_state.dart';


/// ------------------------------------------------------------
/// CartCubit
/// ------------------------------------------------------------
///
/// Cubit responsable de manejar el estado del carrito de
/// compras.
/// ------------------------------------------------------------
/// Responsabilidades:
/// ------------------------------------------------------------
/// - Agregar productos al carrito.
/// - Remover productos del carrito.
/// - Mantener la cantidad de cada producto.
/// - Emitir un nuevo estado ante cualquier cambio.
/// ------------------------------------------------------------
/// Estado manejado:
/// ------------------------------------------------------------
/// - `CartState`
///   Contiene la relación de productos con sus cantidades,
///   así como los valores calculados del carrito.
/// ------------------------------------------------------------
/// Integración:
/// ------------------------------------------------------------
/// - Trabaja en conjunto con los Visitors de dominio
///   (`DiscountsVisitor`, `TaxesVisitor`, `FinalPriceVisitor`)
///   para el cálculo de descuentos, impuestos y precios finales.
/// ------------------------------------------------------------
class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addItem(Product product) {
    try {
      final temporalProducts = Map<Product, int>.from(
        state.productsWithQuantity,
      );
      //validating if item already in cart
      if (temporalProducts.containsKey(product)) {
        temporalProducts[product] = temporalProducts[product]! + 1;
      } else {
        temporalProducts[product] = 1;
      }
      emit(
        state.copyWith(productsWithQuantity: temporalProducts),
      );
    } catch (e) {
      //TODO - manejo de errores
    }
  }

  void removeItem(Product product) {
    try {
      final temporalProducts = Map<Product, int>.from(state.productsWithQuantity);
      //validating if item already in cart
      if (temporalProducts.containsKey(product)) {
        if (temporalProducts[product] == 1) {
          temporalProducts.remove(product);
        } else {
          temporalProducts[product] = temporalProducts[product]! - 1;
        }
      }
      emit(
        state.copyWith(productsWithQuantity: temporalProducts),
      );
    } catch (e) {
      //TODO - manejo de errores
    }
  }
}
