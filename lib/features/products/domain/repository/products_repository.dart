import 'package:flutter_visitor/core.dart' show ProductItem;

abstract interface class ProductsRepository{
  Future<List<ProductItem>> getProducts();
}