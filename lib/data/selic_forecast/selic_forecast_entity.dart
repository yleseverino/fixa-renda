import 'package:fixa_renda/data/util/datetime_converter.dart';
import 'package:floor/floor.dart';

@TypeConverters([DateTimeConverter])
@entity
class SelicForecast {
  @primaryKey
  final int? id;
  final String meeting;
  final String date;
  final double median;

  SelicForecast(
      {required this.id,
      required this.meeting,
      required this.date,
      required this.median});
}
