import 'package:fixa_renda/data/selic_forecast/models/meeting_model.dart';
import 'package:fixa_renda/data/util/datetime_converter.dart';
import 'package:floor/floor.dart';

@TypeConverters([DateTimeConverter, MeetingModelTypeConverter])
@entity
class SelicForecast {
  @primaryKey
  final int? id;
  final MeetingModel meeting;
  final DateTime date;
  final double median;
  final int baseCalculo;

  SelicForecast(
      {required this.id,
      required this.meeting,
      required this.date,
      required this.baseCalculo,
      required this.median});
}
