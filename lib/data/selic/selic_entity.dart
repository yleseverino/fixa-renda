import 'package:floor/floor.dart';
import 'package:fixa_renda/data/util/datetime_converter.dart';

@TypeConverters([DateTimeConverter])
@entity
class Selic {
  @primaryKey
  final DateTime date;
  final double value;

  Selic({required this.date, required this.value});
}
