// ignore_for_file: non_constant_identifier_names

import 'package:fixa_renda/data/selic_forecast/models/meeting_model.dart';
import 'package:fixa_renda/data/selic_forecast/selic_forecast_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'selic_forecast_dto.g.dart';

@JsonSerializable()
class SelicForecastListDto {
  final List<SelicForecastDto> value;

  SelicForecastListDto({required this.value});

  factory SelicForecastListDto.fromJson(Map<String, dynamic> json) =>
      _$SelicForecastListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SelicForecastListDtoToJson(this);
}

@JsonSerializable()
class SelicForecastDto {
  final DateTime Data;
  final String Reuniao;
  final double Mediana;
  final int baseCalculo;

  SelicForecastDto(
      {required this.Data,
      required this.Reuniao,
      required this.Mediana,
      required this.baseCalculo});

  factory SelicForecastDto.fromJson(Map<String, dynamic> json) =>
      _$SelicForecastDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SelicForecastDtoToJson(this);

  int get meeting => int.parse(Reuniao.split('/')[0].replaceAll('R', ''));
  int get meetingYear => int.parse(Reuniao.split('/')[1]);

  SelicForecast toEntity() {
    return SelicForecast(
      id: null,
      date: Data,
      meeting: MeetingModel.fromApi(Reuniao),
      baseCalculo: baseCalculo,
      median: Mediana,
    );
  }
}
