import 'package:flutter_visitor/core/domain/models/product.dart';
import 'package:flutter_visitor/features/products.dart';

class ProductFakeRepo implements ProductsRepository {
  @override
  Future<List<Product>> getProducts() async {
    return ProductsFakeData.products;
  }
}
