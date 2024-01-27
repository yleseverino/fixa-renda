import 'package:dio/dio.dart';
import 'package:fixa_renda/data/selic_forecast/api/selic_forecast_dto.dart';
import 'package:intl/intl.dart';
import 'package:retrofit/http.dart';

part 'selic_forecast_service.g.dart';

@RestApi(
    baseUrl:
        'https://olinda.bcb.gov.br/olinda/servico/Expectativas/versao/v1/odata/ExpectativasMercadoSelic')
abstract class SelicForecastService {
  factory SelicForecastService(Dio dio, {String baseUrl}) =
      _SelicForecastService;

  @GET('')
  Future<SelicForecastListDto> getSelicForecastFromCentralBank({
    @Query('filter') String? filter,
    @Query('\$select') String select = 'Data,Reuniao,Mediana,baseCalculo',
    @Query('\$format') String format = 'json',
    @Query('\$top') String top = '100',
  });
}

String formatFilterDateGreaterThan(DateTime? date) {
  if (date == null) {
    return '';
  }
  return "Data gt '${DateFormat('yyyy-MM-dd').format(date)}'";
}
