import 'package:intl/intl.dart';
import 'package:fixa_renda/data/selic/selic_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'selic_dto.g.dart';

@JsonSerializable()
class SelicDTO {
  final String data;
  final String valor;

  SelicDTO({required this.data, required this.valor});

  factory SelicDTO.fromJson(Map<String, dynamic> json) =>
      _$SelicDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SelicDTOToJson(this);

  Selic toSelic() => Selic(
      date: DateFormat('dd/MM/yyyy').parse(data),
      value: double.parse(valor) / 100);
}
