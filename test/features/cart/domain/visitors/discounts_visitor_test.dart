import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/cart.dart';

void main() {
  final visitor = DiscountsVisitor();

  test('physical product discount is 10% of value', () {
    final product = PhysicalProduct(value: 200.0, id: '', name: '');
    expect(visitor.visitPhysicalProduct(product), closeTo(20.0, 1e-9));
  });

  test('service product discount is 5% of value', () {
    final product = ServiceProduct(value: 150.0, id: '', name: '');
    expect(visitor.visitServiceProduct(product), closeTo(7.5, 1e-9));
  });

  test('imported product discount is 0', () {
    final product = ImportedProduct(value: 1000.0, id: '', name: '');
    expect(visitor.visitImportedProduct(product), 0);
  });

  test('discount constants are defined correctly', () {
    expect(DiscountsVisitor.physicalDiscount, closeTo(0.10, 1e-9));
    expect(DiscountsVisitor.serviceDiscount, closeTo(0.05, 1e-9));
  });
}
