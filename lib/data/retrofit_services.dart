import 'package:fixa_renda/data/selic/api/selic_service.dart';
import 'package:fixa_renda/data/selic_forecast/api/selic_forecast_service.dart';

class RetrofitServices {
  final SelicService _selicService;
  final SelicForecastService _selicForecastService;

  RetrofitServices(
      {required SelicService selicService,
      required SelicForecastService selicForecastService})
      : _selicService = selicService,
        _selicForecastService = selicForecastService;

  SelicService get selicService => _selicService;
  SelicForecastService get selicForecastService => _selicForecastService;
}
