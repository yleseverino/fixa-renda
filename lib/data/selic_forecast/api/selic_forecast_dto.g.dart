// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selic_forecast_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelicForecastListDto _$SelicForecastListDtoFromJson(
        Map<String, dynamic> json) =>
    SelicForecastListDto(
      value: (json['value'] as List<dynamic>)
          .map((e) => SelicForecastDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SelicForecastListDtoToJson(
        SelicForecastListDto instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

SelicForecastDto _$SelicForecastDtoFromJson(Map<String, dynamic> json) =>
    SelicForecastDto(
      Data: DateTime.parse(json['Data'] as String),
      Reuniao: json['Reuniao'] as String,
      Mediana: (json['Mediana'] as num).toDouble(),
      baseCalculo: json['baseCalculo'] as int,
    );

Map<String, dynamic> _$SelicForecastDtoToJson(SelicForecastDto instance) =>
    <String, dynamic>{
      'Data': instance.Data.toIso8601String(),
      'Reuniao': instance.Reuniao,
      'Mediana': instance.Mediana,
      'baseCalculo': instance.baseCalculo,
    };
