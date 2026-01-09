import 'package:intl/intl.dart';

final _formatter = NumberFormat.currency(
  locale: 'es_CO',
  symbol: '\$',
  decimalDigits: 0,
  customPattern: '¤#,##0',
);

extension CurrencyFormatter on num {
  /// ------------------------------------------------------------
  /// formatCurrency
  /// ------------------------------------------------------------
  ///
  /// Formatea un valor numérico como moneda según la
  /// configuración regional de Colombia (`es_CO`).
  /// ------------------------------------------------------------
  /// Comportamiento:
  /// ------------------------------------------------------------
  /// - Utiliza el símbolo `$`.
  /// - No muestra decimales.
  /// - Aplica separadores de miles.
  /// ------------------------------------------------------------
  /// Retorno:
  /// ------------------------------------------------------------
  /// - `String`
  ///   Valor numérico formateado como moneda.
  /// ------------------------------------------------------------
  String formatCurrency() {
    return _formatter.format(this);
  }
}
