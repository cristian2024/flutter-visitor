import 'package:flutter_visitor/core.dart' show Product;

/// ------------------------------------------------------------
/// ProductsRepository
/// ------------------------------------------------------------
///
/// Contrato que define las operaciones relacionadas con
/// la obtención de productos.
/// ------------------------------------------------------------
/// Responsabilidad:
/// ------------------------------------------------------------
/// - Proveer el listado de productos desde una fuente de datos,
///   independientemente de su origen (API, base de datos local,
///   mock, etc.).
/// ------------------------------------------------------------
/// Métodos:
/// ------------------------------------------------------------
/// * getProducts()
///   Obtiene la lista de productos disponibles.
/// ------------------------------------------------------------
/// Retorno:
/// ------------------------------------------------------------
/// - `Future<List<Product>>`
///   Lista de productos obtenidos.
/// ------------------------------------------------------------
abstract interface class ProductsRepository {
  Future<List<Product>> getProducts();
}
