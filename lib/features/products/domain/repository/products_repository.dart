import 'package:flutter_visitor/core.dart' show Product;

abstract interface class ProductsRepository{
  Future<List<Product>> getProducts();
}