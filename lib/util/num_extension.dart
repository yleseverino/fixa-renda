import 'package:intl/intl.dart';

extension InvestNum on num {
  String toCurrency({int? decimalDigits}) {
    return NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: decimalDigits,
    ).format(this);
  }
}
