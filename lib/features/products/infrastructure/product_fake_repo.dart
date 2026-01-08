import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/products.dart';

class ProductFakeRepo implements ProductsRepository {
  @override
  Future<List<ProductItem>> getProducts() async {
    return ProductsFakeData.products;
  }
}
