import 'package:intl/intl.dart';

extension DatetimeBR on DateTime {
  String toBRDate() {
    final dateFormatter = DateFormat('dd/MM/yyyy');
    return dateFormatter.format(toLocal());
  }
}
