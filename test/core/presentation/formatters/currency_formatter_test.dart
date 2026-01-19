import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_visitor/core.dart';

void main() {
  group('CurrencyFormatter', () {
    test('formats small values correctly', () {
      expect(100.formatCurrency(), '\$100');
      expect(50.formatCurrency(), '\$50');
    });

    test('formats large values with thousands separator', () {
      expect(1000.formatCurrency(), '\$1.000');
      expect(10000.formatCurrency(), '\$10.000');
      expect(100000.formatCurrency(), '\$100.000');
      expect(1000000.formatCurrency(), '\$1.000.000');
    });

    test('formats decimal values rounding to integer', () {
      expect(100.5.formatCurrency(), '\$101');
      expect(100.9.formatCurrency(), '\$101');
      expect(999.49.formatCurrency(), '\$999');
      expect(999.50.formatCurrency(), '\$1.000');
    });

    test('formats zero correctly', () {
      expect(0.formatCurrency(), '\$0');
      expect(0.0.formatCurrency(), '\$0');
    });

    test('formats negative values correctly', () {
      expect((-100).formatCurrency(), '-\$100');
      expect((-1000).formatCurrency(), '-\$1.000');
    });

    test('formats typical product values correctly', () {
      expect(200.formatCurrency(), '\$200');
      expect(1500.formatCurrency(), '\$1.500');
      expect(350000.formatCurrency(), '\$350.000');
      expect(4800000.formatCurrency(), '\$4.800.000');
    });
  });
}