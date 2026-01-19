import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/cart.dart';

void main() {
  final visitor = FinalPriceVisitor();

  test('physical product final price includes 19% tax and 10% discount', () {
    // value + tax - discount = 200 + 38 - 20 = 218
    final product = PhysicalProduct(value: 200.0, id: '', name: '');
    expect(visitor.visitPhysicalProduct(product), 218.0);
  });

  test('service product final price includes 19% tax and 5% discount', () {
    // value + tax - discount = 150 + 28.5 - 7.5 = 171
    final product = ServiceProduct(value: 150.0, id: '', name: '');
    expect(visitor.visitServiceProduct(product), 171.0);
  });

  test('imported product final price includes 24% tax and no discount', () {
    // value + tax - discount = 1000 + 240 - 0 = 1240
    final product = ImportedProduct(value: 1000.0, id: '', name: '');
    expect(visitor.visitImportedProduct(product), 1240.0);
  });

  test('physical product with different value', () {
    // value + tax - discount = 500 + 95 - 50 = 545
    final product = PhysicalProduct(value: 500.0, id: '', name: '');
    expect(visitor.visitPhysicalProduct(product), 545.0);
  });

  test('service product with different value', () {
    // value + tax - discount = 1000 + 190 - 50 = 1140
    final product = ServiceProduct(value: 1000.0, id: '', name: '');
    expect(visitor.visitServiceProduct(product), 1140.0);
  });

  test('imported product with different value', () {
    // value + tax - discount = 500 + 120 - 0 = 620
    final product = ImportedProduct(value: 500.0, id: '', name: '');
    expect(visitor.visitImportedProduct(product), 620.0);
  });

  test('final price is always positive for all product types', () {
    final physical = PhysicalProduct(value: 100.0, id: '', name: '');
    final service = ServiceProduct(value: 100.0, id: '', name: '');
    final imported = ImportedProduct(value: 100.0, id: '', name: '');

    expect(visitor.visitPhysicalProduct(physical), greaterThan(0));
    expect(visitor.visitServiceProduct(service), greaterThan(0));
    expect(visitor.visitImportedProduct(imported), greaterThan(0));
  });
}