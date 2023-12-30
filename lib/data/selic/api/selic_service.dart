import 'package:dio/dio.dart';
import 'package:fixa_renda/data/selic/api/selic_dto.dart';
import 'package:retrofit/http.dart';

part 'selic_service.g.dart';

@RestApi(baseUrl: 'https://api.bcb.gov.br/dados/serie/bcdata.sgs.11')
abstract class SelicService {
  factory SelicService(Dio dio, {String baseUrl}) = _SelicService;

  @GET('/dados')
  Future<List<SelicDTO>> getSelicAverage({
    @Query('dataInicial') required String startDate,
    @Query('dataFinal') required String endDate,
    @Query('formato') String format = 'json',
  });
}
