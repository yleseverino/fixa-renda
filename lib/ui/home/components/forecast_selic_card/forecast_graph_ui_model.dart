import 'package:fixa_renda/data/selic_forecast/selic_forecast_entity.dart';

class ForecastGraphUiModel {
  final String label;
  final double value;
  final String month;

  ForecastGraphUiModel({required this.label, required this.value, required this.month});

  factory ForecastGraphUiModel.fromEntity(SelicForecast entity) {
    return ForecastGraphUiModel(
      label: 'Reunião ${entity.meeting.label}',
      value: entity.median,
      month: entity.meeting.month,
    );
  }
}