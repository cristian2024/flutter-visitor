import 'package:flutter_visitor/core/domain/visitors/product_visitor.dart';

import 'product.dart';

class ImportedProduct extends Product {
  const ImportedProduct({
    required super.id,
    required super.name,
    required super.value,
    super.description,
    super.imageLink,
  });

  @override
  double accept(ProductVisitor visitor) {
    return visitor.visitImportedProduct(this);
  }
}
