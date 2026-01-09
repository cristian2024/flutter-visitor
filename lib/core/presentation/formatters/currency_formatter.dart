
import 'package:intl/intl.dart';

final _formatter = NumberFormat.currency(
  locale: 'es_CO',
  symbol: '\$',
  decimalDigits: 0,
  customPattern: '¤#,##0',
);


extension CurrencyFormatter on num{
  String formatCurrency(){
    return _formatter.format(this);
  }
}