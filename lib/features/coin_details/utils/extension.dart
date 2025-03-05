import 'package:intl/intl.dart';

final currencyFormat = NumberFormat(
  '#,##0',
  'en_US',
);
final valueFormat = NumberFormat(
  '#,##0.00',
  'en_US',
);

extension DoubleExtension on double? {
  String formatValue() {
    return this == null ? '-' : (currencyFormat.format(this));
  }

  String formatValue2() {
    return this == null ? '-' : (valueFormat.format(this));
  }
}
