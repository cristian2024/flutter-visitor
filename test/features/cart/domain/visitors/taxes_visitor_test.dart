import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visitor/core.dart';
import 'package:flutter_visitor/features/cart.dart';

void main() {
  final visitor = TaxesVisitor();

  test('physical product tax is 19% VAT of value', () {
    final product = PhysicalProduct(value: 200.0, id: '', name: '');
    expect(visitor.visitPhysicalProduct(product), 38.0);
  });

  test('service product tax is 19% VAT of value', () {
    final product = ServiceProduct(value: 150.0, id: '', name: '');
    expect(visitor.visitServiceProduct(product), 28.5);
  });

  test('imported product tax is 24% (19% VAT + 5% import duty) of value', () {
    final product = ImportedProduct(value: 1000.0, id: '', name: '');
    expect(visitor.visitImportedProduct(product), 240.0);
  });

  test('tax constants are defined correctly', () {
    expect(TaxesVisitor.vat, 0.19);
    expect(TaxesVisitor.importDuty, 0.05);
  });

  test('physical product with different value', () {
    final product = PhysicalProduct(value: 500.0, id: '', name: '');
    expect(visitor.visitPhysicalProduct(product), 95.0);
  });

  test('service product with different value', () {
    final product = ServiceProduct(value: 1000.0, id: '', name: '');
    expect(visitor.visitServiceProduct(product), 190.0);
  });

  test('imported product with different value', () {
    final product = ImportedProduct(value: 500.0, id: '', name: '');
    expect(visitor.visitImportedProduct(product), 120.0);
  });
}