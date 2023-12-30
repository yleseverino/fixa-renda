import 'package:floor/floor.dart';
import 'package:fixa_renda/data/util/datetime_converter.dart';

@TypeConverters([DateTimeConverter])
@entity
class Investment {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final double investedAmount;
  final double interestRate;
  final DateTime date;

  Investment(
      {required this.id,
      required this.name,
      required this.investedAmount,
      required this.interestRate,
      required this.date});
}
